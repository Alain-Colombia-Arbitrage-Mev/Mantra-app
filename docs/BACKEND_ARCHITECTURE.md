# Mantras — Backend Architecture

> **App:** Mantras
> **Platform:** Flutter (iOS · Android · Web)
> **Purpose:** Astrology, numerology, meditation & wellness — personalized spiritual audio experiences
> **Architecture pattern:** Flutter frontend → Supabase BaaS (Auth + PostgreSQL + Storage + Realtime + Edge Functions) + third-party integrations (Stripe, RevenueCat, FCM, ElevenLabs, OpenAI)

---

## Table of Contents

1. [Overview](#1-overview)
2. [Tech Stack](#2-tech-stack)
3. [Database Schema](#3-database-schema)
4. [API Endpoints](#4-api-endpoints)
5. [Supabase Edge Functions](#5-supabase-edge-functions)
6. [Flutter Integration Pattern](#6-flutter-integration-pattern)
7. [Environment Variables](#7-environment-variables)
8. [Deployment Pipeline](#8-deployment-pipeline)
9. [Cost Estimation](#9-cost-estimation)
10. [Implementation Roadmap](#10-implementation-roadmap)

---

## 1. Overview

Mantras is a spiritual wellness platform that combines guided meditation, binaural frequencies, astrology (planetary hours, mirror hours, moon phases), sacred numerology, and AI-generated personalized audio. Users can book live sessions with guides, generate custom mantras through an "Alchemist" AI engine, track their spiritual practice, and unlock premium content via subscription.

**Key user flows:**
- Browse and play meditations (free + premium)
- Receive real-time planetary / mirror hour push notifications
- Generate personalized audio in the Alchemist (brain state + frequency + soundscape + voice)
- Book and attend live sessions with spiritual guides
- Track rituals, gratitude journaling, and daily intentions
- Subscribe to the PRO plan via in-app purchase or web checkout

---

## 2. Tech Stack

| Layer | Technology | Rationale |
|---|---|---|
| **Database** | PostgreSQL via Supabase | ACID, row-level security, full-text search, PostGIS for geo |
| **Auth** | Supabase Auth | Email/password, Google, Apple, phone (WhatsApp/SMS via Twilio) |
| **API** | Supabase REST (auto-generated) + Edge Functions | Zero-config REST; Edge Functions for business logic |
| **Storage** | Supabase Storage | S3-compatible; CDN transform for images; resumable upload for audio |
| **Realtime** | Supabase Realtime | Live session status, community presence, notification delivery |
| **Payments (web)** | Stripe Billing | Subscription management, webhooks, customer portal |
| **Payments (mobile)** | RevenueCat | iOS App Store + Google Play IAP abstraction |
| **Push Notifications** | Firebase Cloud Messaging (FCM) + APNs | Cross-platform; topic subscriptions for planetary events |
| **AI Voice / TTS** | ElevenLabs API | Voice cloning, text-to-speech for personalized mantras |
| **Speech-to-Text** | OpenAI Whisper | Transcription for user voice recordings |
| **Audio CDN** | Cloudflare R2 + Cloudflare Stream | Low-latency audio delivery; adaptive bitrate for mobile |
| **Analytics** | PostHog (self-hosted or cloud) | Event tracking, funnels, session replay |
| **Backend runtime** | Deno (Supabase Edge Functions) | TypeScript, low cold-start, global edge |

---

## 3. Database Schema

All tables use UUIDs as primary keys and include `created_at` / `updated_at` timestamps. Row-Level Security (RLS) is enabled on all user-owned tables.

```sql
-- ─────────────────────────────────────────────────────────────────────────────
-- EXTENSIONS
-- ─────────────────────────────────────────────────────────────────────────────
create extension if not exists "uuid-ossp";
create extension if not exists "pg_trgm";   -- full-text fuzzy search
create extension if not exists "pgcrypto";  -- gen_random_bytes for referral codes


-- ─────────────────────────────────────────────────────────────────────────────
-- USERS & AUTH
-- ─────────────────────────────────────────────────────────────────────────────

-- Mirrors auth.users; populated via Supabase Auth triggers.
create table public.users (
  id             uuid primary key references auth.users(id) on delete cascade,
  email          text unique not null,
  name           text,
  avatar_url     text,
  plan           text not null default 'free' check (plan in ('free', 'pro', 'annual')),
  streak_days    int not null default 0,
  total_hours    numeric(8,2) not null default 0,
  referral_code  text unique,
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now()
);

create table public.user_preferences (
  user_id                 uuid primary key references public.users(id) on delete cascade,
  language                text not null default 'es',
  notifications_enabled   boolean not null default true,
  wake_time               time,           -- e.g. 06:30
  default_voice_id        text,           -- ElevenLabs voice_id
  binaural_volume         numeric(3,2) not null default 0.7,
  updated_at              timestamptz not null default now()
);


-- ─────────────────────────────────────────────────────────────────────────────
-- SUBSCRIPTIONS
-- ─────────────────────────────────────────────────────────────────────────────

create table public.subscriptions (
  id                  uuid primary key default uuid_generate_v4(),
  user_id             uuid not null references public.users(id) on delete cascade,
  plan_type           text not null check (plan_type in ('pro_monthly', 'pro_annual')),
  provider            text not null check (provider in ('stripe', 'apple', 'google')),
  provider_id         text,               -- Stripe subscription ID or RC entitlement ID
  status              text not null check (status in ('active', 'trialing', 'canceled', 'past_due')),
  trial_ends_at       timestamptz,
  current_period_start timestamptz,
  current_period_end  timestamptz,
  canceled_at         timestamptz,
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now()
);

create index subscriptions_user_id_idx on public.subscriptions(user_id);


-- ─────────────────────────────────────────────────────────────────────────────
-- CONTENT
-- ─────────────────────────────────────────────────────────────────────────────

create table public.meditations (
  id               uuid primary key default uuid_generate_v4(),
  title            text not null,
  description      text,
  category         text not null,        -- 'sleep', 'abundance', 'healing', 'focus', etc.
  duration_seconds int not null,
  frequency_hz     int,                  -- e.g. 528, 432, 396
  brain_state      text,                 -- 'theta', 'alpha', 'delta', 'gamma'
  audio_url        text not null,
  thumbnail_url    text,
  accent_color     text,                 -- hex, used in UI cards
  play_count       bigint not null default 0,
  is_premium       boolean not null default false,
  published_at     timestamptz,
  created_at       timestamptz not null default now()
);

create index meditations_category_idx on public.meditations(category);
create index meditations_brain_state_idx on public.meditations(brain_state);
create index meditations_search_idx on public.meditations using gin(to_tsvector('spanish', title || ' ' || coalesce(description, '')));

create table public.collections (
  id               uuid primary key default uuid_generate_v4(),
  title            text not null,
  description      text,
  cover_url        text,
  accent_color     text,
  track_count      int not null default 0,
  total_duration   int not null default 0,  -- seconds
  is_premium       boolean not null default false,
  sort_order       int not null default 0,
  created_at       timestamptz not null default now()
);

create table public.collection_tracks (
  collection_id    uuid not null references public.collections(id) on delete cascade,
  meditation_id    uuid not null references public.meditations(id) on delete cascade,
  position         int not null,
  primary key (collection_id, meditation_id)
);

create table public.user_liked_meditations (
  user_id          uuid not null references public.users(id) on delete cascade,
  meditation_id    uuid not null references public.meditations(id) on delete cascade,
  created_at       timestamptz not null default now(),
  primary key (user_id, meditation_id)
);


-- ─────────────────────────────────────────────────────────────────────────────
-- FREQUENCIES & SOUNDSCAPES
-- ─────────────────────────────────────────────────────────────────────────────

create table public.frequencies (
  id               uuid primary key default uuid_generate_v4(),
  hz_value         int not null,
  name             text not null,           -- 'Amor Universal', 'Reparación ADN', etc.
  description      text,
  type             text not null check (type in ('solfeggio', 'binaural', 'schumann')),
  audio_url        text not null,
  is_premium       boolean not null default false,
  sort_order       int not null default 0
);

create table public.soundscapes (
  id               uuid primary key default uuid_generate_v4(),
  name             text not null,
  icon             text not null,           -- lucide icon name
  audio_url        text not null,
  category         text not null check (category in ('nature', 'cosmic', 'urban', 'instrument')),
  is_premium       boolean not null default false
);


-- ─────────────────────────────────────────────────────────────────────────────
-- ASTROLOGY & METAPHYSICS
-- ─────────────────────────────────────────────────────────────────────────────

create table public.chakras (
  id               uuid primary key default uuid_generate_v4(),
  name             text not null,           -- 'Raíz', 'Sacral', etc.
  sanskrit_name    text not null,
  color            text not null,           -- hex
  frequency_hz     int not null,
  description      text,
  body_location    text,
  meditation_id    uuid references public.meditations(id),
  sort_order       int not null default 0
);

create table public.moon_phases (
  id               uuid primary key default uuid_generate_v4(),
  phase_name       text not null check (phase_name in ('new', 'waxing_crescent', 'first_quarter', 'waxing_gibbous', 'full', 'waning_gibbous', 'last_quarter', 'waning_crescent')),
  date             date not null unique,
  description      text,
  power_level      int check (power_level between 1 and 10)
);

create table public.rituals (
  id               uuid primary key default uuid_generate_v4(),
  name             text not null,
  description      text,
  duration_minutes int not null,
  moon_phase       text,                    -- null means available all phases
  category         text not null check (category in ('lunar', 'chakra', 'manifestation', 'healing')),
  audio_url        text,
  steps            jsonb,                   -- [{order:1, title:'...', duration:120}]
  is_premium       boolean not null default false
);

create table public.planetary_hour_templates (
  day_of_week      int not null check (day_of_week between 0 and 6),  -- 0=Sunday
  hour_of_day      int not null check (hour_of_day between 0 and 23),
  planet           text not null check (planet in ('Sun', 'Moon', 'Mars', 'Mercury', 'Jupiter', 'Venus', 'Saturn')),
  power_level      int check (power_level between 1 and 5),
  description      text,
  primary key (day_of_week, hour_of_day)
);

create table public.mirror_hours (
  time_value       text primary key,        -- '11:11', '22:22', etc.
  meaning          text not null,
  affirmation      text not null,
  voice_audio_url  text,
  numerological_code text
);

create table public.activation_codes (
  code             text primary key,        -- 'AAA', '888', 'KRYON', etc.
  name             text not null,
  description      text,
  category         text not null check (category in ('numerology', 'frequency', 'angelic', 'galactic')),
  audio_url        text,
  is_premium       boolean not null default false
);


-- ─────────────────────────────────────────────────────────────────────────────
-- MANIFESTATION & JOURNALING
-- ─────────────────────────────────────────────────────────────────────────────

create table public.daily_intentions (
  id               uuid primary key default uuid_generate_v4(),
  user_id          uuid not null references public.users(id) on delete cascade,
  text             text not null,
  date             date not null default current_date,
  completed        boolean not null default false,
  completed_at     timestamptz,
  unique (user_id, date)
);

create table public.gratitude_entries (
  id               uuid primary key default uuid_generate_v4(),
  user_id          uuid not null references public.users(id) on delete cascade,
  entry1           text,
  entry2           text,
  entry3           text,
  date             date not null default current_date,
  unique (user_id, date)
);

create table public.affirmations (
  id               uuid primary key default uuid_generate_v4(),
  text             text not null,
  category         text not null,
  frequency_hz     int,
  language         text not null default 'es',
  is_active        boolean not null default true
);


-- ─────────────────────────────────────────────────────────────────────────────
-- SESSIONS & BOOKING
-- ─────────────────────────────────────────────────────────────────────────────

create table public.session_guides (
  id               uuid primary key default uuid_generate_v4(),
  name             text not null,
  specialty        text not null,           -- 'Meditación Theta', 'Astrología', etc.
  bio              text,
  years_experience int not null default 0,
  avatar_url       text,
  rating           numeric(3,2) not null default 5.0,
  session_count    int not null default 0,
  available_today  boolean not null default false,
  price_per_hour   numeric(8,2),
  platforms        text[] not null default array['zoom'],
  is_active        boolean not null default true
);

create table public.session_bookings (
  id               uuid primary key default uuid_generate_v4(),
  user_id          uuid not null references public.users(id) on delete cascade,
  guide_id         uuid not null references public.session_guides(id),
  session_type     text not null check (session_type in ('individual', 'group', 'astrology', 'healing')),
  scheduled_date   date not null,
  scheduled_time   time not null,
  duration_minutes int not null default 60,
  platform         text not null check (platform in ('zoom', 'meet', 'teams', 'whatsapp')),
  status           text not null default 'pending' check (status in ('pending', 'confirmed', 'completed', 'canceled')),
  notes            text,
  meeting_url      text,
  price            numeric(8,2),
  created_at       timestamptz not null default now()
);

create index session_bookings_user_idx on public.session_bookings(user_id);
create index session_bookings_guide_idx on public.session_bookings(guide_id);
create index session_bookings_date_idx on public.session_bookings(scheduled_date);

create table public.session_history (
  id               uuid primary key default uuid_generate_v4(),
  booking_id       uuid not null references public.session_bookings(id) on delete cascade,
  actual_duration  int,                     -- minutes
  rating           int check (rating between 1 and 5),
  review           text,
  completed_at     timestamptz
);


-- ─────────────────────────────────────────────────────────────────────────────
-- ALARMS
-- ─────────────────────────────────────────────────────────────────────────────

create table public.alarms (
  id               uuid primary key default uuid_generate_v4(),
  user_id          uuid not null references public.users(id) on delete cascade,
  hour             int not null check (hour between 0 and 23),
  minute           int not null check (minute between 0 and 59),
  name             text not null,
  days             int[] not null default array[1,2,3,4,5],  -- ISO weekday: 1=Mon
  voice_id         text,                    -- ElevenLabs voice_id
  frequency_hz     int,
  vibrate          boolean not null default true,
  light_therapy    boolean not null default false,
  is_active        boolean not null default true,
  created_at       timestamptz not null default now()
);


-- ─────────────────────────────────────────────────────────────────────────────
-- VOICE & AI AUDIO
-- ─────────────────────────────────────────────────────────────────────────────

create table public.voice_clones (
  id               uuid primary key default uuid_generate_v4(),
  user_id          uuid not null references public.users(id) on delete cascade,
  elevenlabs_voice_id text,
  training_audio_url text not null,
  quality_percent  int,
  status           text not null default 'processing' check (status in ('processing', 'ready', 'failed')),
  created_at       timestamptz not null default now()
);

create table public.user_audio_creations (
  id               uuid primary key default uuid_generate_v4(),
  user_id          uuid not null references public.users(id) on delete cascade,
  brain_state      text,
  frequency_hz     int,
  soundscape_id    uuid references public.soundscapes(id),
  mantra_text      text,
  voice_id         text,
  output_url       text,
  duration_seconds int,
  status           text not null default 'processing' check (status in ('processing', 'ready', 'failed')),
  created_at       timestamptz not null default now()
);

create index user_audio_creations_user_idx on public.user_audio_creations(user_id);


-- ─────────────────────────────────────────────────────────────────────────────
-- GAMIFICATION & SOCIAL
-- ─────────────────────────────────────────────────────────────────────────────

create table public.achievements (
  id               uuid primary key default uuid_generate_v4(),
  name             text not null,
  description      text,
  icon             text not null,
  category         text not null check (category in ('streak', 'listening', 'sessions', 'journaling', 'social')),
  threshold        int not null,            -- e.g. streak_days >= 7
  is_active        boolean not null default true
);

create table public.user_achievements (
  user_id          uuid not null references public.users(id) on delete cascade,
  achievement_id   uuid not null references public.achievements(id),
  earned_at        timestamptz not null default now(),
  primary key (user_id, achievement_id)
);

create table public.referral_codes (
  code             text primary key,
  user_id          uuid not null references public.users(id) on delete cascade,
  uses             int not null default 0,
  max_uses         int not null default 50,
  bonus_days       int not null default 7,  -- free PRO days granted per referral
  expires_at       timestamptz,
  created_at       timestamptz not null default now()
);

create table public.referral_uses (
  code             text not null references public.referral_codes(code),
  referred_user_id uuid not null references public.users(id) on delete cascade,
  created_at       timestamptz not null default now(),
  primary key (code, referred_user_id)
);


-- ─────────────────────────────────────────────────────────────────────────────
-- TEHILIM
-- ─────────────────────────────────────────────────────────────────────────────

create table public.tehilim_chapters (
  id               uuid primary key default uuid_generate_v4(),
  chapter_number   int not null unique check (chapter_number between 1 and 150),
  hebrew_text      text not null,
  spanish_text     text not null,
  spiritual_meaning text,
  audio_url        text,
  play_count       bigint not null default 0
);

create table public.daily_verses (
  date             date primary key,
  tehilim_id       uuid not null references public.tehilim_chapters(id),
  verse_number     int not null,
  theme            text
);


-- ─────────────────────────────────────────────────────────────────────────────
-- NOTIFICATIONS
-- ─────────────────────────────────────────────────────────────────────────────

create table public.notification_preferences (
  user_id                 uuid primary key references public.users(id) on delete cascade,
  mirror_hours            boolean not null default true,
  planetary_hours         boolean not null default true,
  session_reminder        boolean not null default true,
  daily_ritual            boolean not null default true,
  bio_hack_morning        boolean not null default false,
  moon_phase              boolean not null default true,
  updated_at              timestamptz not null default now()
);

create table public.device_tokens (
  id               uuid primary key default uuid_generate_v4(),
  user_id          uuid not null references public.users(id) on delete cascade,
  token            text not null unique,
  platform         text not null check (platform in ('ios', 'android', 'web')),
  created_at       timestamptz not null default now(),
  last_seen_at     timestamptz not null default now()
);

create index device_tokens_user_idx on public.device_tokens(user_id);

create table public.scheduled_notifications (
  id               uuid primary key default uuid_generate_v4(),
  user_id          uuid references public.users(id) on delete cascade,  -- null = broadcast
  type             text not null,  -- 'mirror_hour', 'planetary', 'session_reminder', etc.
  trigger_time     timestamptz not null,
  title            text not null,
  body             text not null,
  data             jsonb,
  sent_at          timestamptz,
  created_at       timestamptz not null default now()
);

create index scheduled_notifications_trigger_idx on public.scheduled_notifications(trigger_time)
  where sent_at is null;
```

### Row-Level Security examples

```sql
-- Users can only read/update their own profile.
alter table public.users enable row level security;
create policy "Users: own row" on public.users
  for all using (auth.uid() = id);

-- Meditations are readable by all authenticated users;
-- premium content is further filtered in the API layer.
alter table public.meditations enable row level security;
create policy "Meditations: authenticated read" on public.meditations
  for select using (auth.role() = 'authenticated');

-- Daily intentions are private per user.
alter table public.daily_intentions enable row level security;
create policy "Intentions: own rows" on public.daily_intentions
  for all using (auth.uid() = user_id);
```

---

## 4. API Endpoints

The Supabase REST API is auto-generated from the schema and exposed at `https://<project>.supabase.co/rest/v1/`. Custom business logic is handled by Edge Functions at `https://<project>.supabase.co/functions/v1/`.

All requests require the `Authorization: Bearer <token>` header. Anonymous reads use the `apikey` header with the anon key.

### 4.1 Auth

```
POST /auth/v1/signup
  Body: { email, password }
  Response: { user, session }

POST /auth/v1/token?grant_type=password
  Body: { email, password }
  Response: { access_token, refresh_token, user }

POST /auth/v1/token?grant_type=refresh_token
  Body: { refresh_token }
  Response: { access_token, refresh_token }

POST /functions/v1/auth-social
  Body: { provider: 'google' | 'apple', id_token }
  Response: { access_token, refresh_token, user, is_new_user }

POST /functions/v1/auth-phone
  Body: { phone, code }   -- WhatsApp/SMS OTP verify
  Response: { access_token }
```

### 4.2 User

```
GET    /rest/v1/users?id=eq.<uid>
         Response: [{ id, email, name, avatar_url, plan, streak_days, total_hours }]

PATCH  /rest/v1/users?id=eq.<uid>
         Body: { name?, avatar_url?, ... }

GET    /rest/v1/user_preferences?user_id=eq.<uid>

PATCH  /rest/v1/user_preferences?user_id=eq.<uid>
         Body: { language?, notifications_enabled?, wake_time?, default_voice_id? }

GET    /functions/v1/user-stats
         Response: { streak_days, total_hours, sessions_count, achievements_count }

GET    /rest/v1/user_achievements?user_id=eq.<uid>&select=*,achievement:achievements(*)
         Response: [{ earned_at, achievement: { name, icon, description } }]
```

### 4.3 Content

```
GET  /rest/v1/meditations?category=eq.sleep&order=play_count.desc&limit=20
GET  /rest/v1/meditations?brain_state=eq.theta&is_premium=eq.false
GET  /rest/v1/meditations?id=eq.<id>&select=*

GET  /rest/v1/collections?select=*,collection_tracks(position,meditation:meditations(*))&order=sort_order
GET  /rest/v1/collections?id=eq.<id>&select=*,collection_tracks(position,meditation:meditations(*))

GET  /rest/v1/frequencies?order=hz_value
GET  /rest/v1/soundscapes?category=eq.nature

-- Full-text search:
GET  /rest/v1/meditations?title=plfts.abundancia

-- Likes:
POST   /rest/v1/user_liked_meditations    Body: { meditation_id }
DELETE /rest/v1/user_liked_meditations?user_id=eq.<uid>&meditation_id=eq.<mid>
```

### 4.4 Astrology

```
GET  /functions/v1/planetary-hours?date=2026-03-15&timezone=America/Buenos_Aires
  Response: [{ planet, start_time, end_time, power_level, description, is_current }]

GET  /rest/v1/mirror_hours?order=time_value
GET  /rest/v1/mirror_hours?time_value=eq.11:11

GET  /rest/v1/activation_codes?category=eq.numerology&is_premium=eq.false
GET  /rest/v1/activation_codes?order=category

GET  /functions/v1/moon-phase?date=2026-03-15
  Response: { phase_name, date, description, power_level, next_full_moon, days_until_full }
```

### 4.5 Metaphysics

```
GET  /rest/v1/chakras?select=*,meditation:meditations(id,title,audio_url)&order=sort_order
GET  /rest/v1/rituals?moon_phase=eq.full&is_premium=eq.false
GET  /rest/v1/affirmations?category=eq.abundance&language=eq.es
GET  /rest/v1/tehilim_chapters?chapter_number=eq.23
GET  /rest/v1/daily_verses?date=eq.2026-03-15&select=*,tehilim:tehilim_chapters(*)
```

### 4.6 Sessions

```
GET  /rest/v1/session_guides?is_active=eq.true&available_today=eq.true&select=*

POST /functions/v1/book-session
  Body: { guide_id, session_type, scheduled_date, scheduled_time, platform, notes }
  Response: { booking_id, meeting_url, confirmation_sent }

GET  /rest/v1/session_bookings?user_id=eq.<uid>&status=eq.confirmed&order=scheduled_date
GET  /rest/v1/session_bookings?user_id=eq.<uid>&status=eq.completed&select=*,history:session_history(*)

PATCH /rest/v1/session_bookings?id=eq.<id>
  Body: { status: 'canceled' }

POST /rest/v1/session_history
  Body: { booking_id, rating, review }
```

### 4.7 Audio & Alchemist

```
POST /functions/v1/generate-audio
  Body: {
    brain_state: 'theta' | 'alpha' | 'delta' | 'gamma',
    frequency_hz: 528,
    soundscape_id: '<uuid>',
    mantra_text: 'Soy abundancia...',
    voice_id: '<elevenlabs_id>'
  }
  Response: { creation_id, status: 'processing' }
  -- Poll or subscribe to Realtime channel 'audio_creations:<user_id>' for completion.

GET  /rest/v1/user_audio_creations?user_id=eq.<uid>&order=created_at.desc

POST /functions/v1/voice-clone
  Body: multipart/form-data { audio: <blob> }
  Response: { clone_id, status: 'processing' }

GET  /rest/v1/voice_clones?user_id=eq.<uid>&status=eq.ready
```

### 4.8 Alarms

```
GET    /rest/v1/alarms?user_id=eq.<uid>
POST   /rest/v1/alarms            Body: { hour, minute, name, days, voice_id, frequency_hz, ... }
PATCH  /rest/v1/alarms?id=eq.<id> Body: { is_active?, name?, ... }
DELETE /rest/v1/alarms?id=eq.<id>
```

### 4.9 Journaling & Manifestation

```
GET    /rest/v1/daily_intentions?user_id=eq.<uid>&date=eq.2026-03-15
POST   /rest/v1/daily_intentions  Body: { text, date }
PATCH  /rest/v1/daily_intentions?id=eq.<id>  Body: { completed: true }

GET    /rest/v1/gratitude_entries?user_id=eq.<uid>&order=date.desc&limit=30
POST   /rest/v1/gratitude_entries  Body: { entry1, entry2, entry3, date }
PATCH  /rest/v1/gratitude_entries?id=eq.<id>
```

### 4.10 Subscriptions

```
POST /functions/v1/subscription-create
  Body: { plan: 'pro_monthly' | 'pro_annual', provider: 'stripe' }
  Response: { client_secret }  -- Stripe PaymentIntent

POST /functions/v1/subscription-revenuecat
  Body: { product_id, transaction_receipt, provider: 'apple' | 'google' }
  Response: { success, plan, expires_at }

GET  /functions/v1/subscription-status
  Response: { plan, status, current_period_end, cancel_at_period_end }

POST /functions/v1/subscription-cancel
  Response: { canceled_at, access_until }

-- Stripe webhook (unauthenticated, verified by Stripe-Signature header):
POST /functions/v1/stripe-webhook
```

### 4.11 Social & Referrals

```
POST /functions/v1/referral-generate
  Response: { code, bonus_days }

POST /functions/v1/referral-redeem
  Body: { code }
  Response: { success, bonus_days_granted, referrer_rewarded }

GET  /functions/v1/referral-stats
  Response: { code, uses, pending_bonus_days, total_referred }
```

### 4.12 Notifications

```
POST /rest/v1/device_tokens
  Body: { token, platform }

GET  /rest/v1/notification_preferences?user_id=eq.<uid>
PATCH /rest/v1/notification_preferences?user_id=eq.<uid>
  Body: { mirror_hours?, planetary_hours?, session_reminder?, ... }

-- Internal (Edge Function → FCM, not called from client):
POST /functions/v1/send-notification
  Body: { user_id, type, title, body, data }
```

---

## 5. Supabase Edge Functions

Edge Functions are deployed to Deno on Supabase's global edge network. They run in isolated V8 isolates with sub-100ms cold starts.

### 5.1 `generate-audio`

Orchestrates the Alchemist audio generation pipeline.

```typescript
// supabase/functions/generate-audio/index.ts
import { serve } from 'https://deno.land/std@0.177.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

interface GenerateAudioRequest {
  brain_state: string;
  frequency_hz: number;
  soundscape_id: string;
  mantra_text: string;
  voice_id: string;
}

serve(async (req) => {
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  );

  const authHeader = req.headers.get('Authorization');
  const { data: { user } } = await supabase.auth.getUser(
    authHeader?.replace('Bearer ', '') ?? '',
  );
  if (!user) return new Response('Unauthorized', { status: 401 });

  const body: GenerateAudioRequest = await req.json();

  // 1. Insert creation record (status=processing).
  const { data: creation } = await supabase
    .from('user_audio_creations')
    .insert({ user_id: user.id, ...body, status: 'processing' })
    .select('id')
    .single();

  // 2. Fetch soundscape audio URL.
  const { data: soundscape } = await supabase
    .from('soundscapes')
    .select('audio_url')
    .eq('id', body.soundscape_id)
    .single();

  // 3. Generate TTS mantra via ElevenLabs.
  const ttsResponse = await fetch(
    `https://api.elevenlabs.io/v1/text-to-speech/${body.voice_id}`,
    {
      method: 'POST',
      headers: {
        'xi-api-key': Deno.env.get('ELEVENLABS_API_KEY')!,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        text: body.mantra_text,
        model_id: 'eleven_multilingual_v2',
        voice_settings: { stability: 0.5, similarity_boost: 0.75 },
      }),
    },
  );

  const ttsBuffer = await ttsResponse.arrayBuffer();

  // 4. Upload TTS audio to Supabase Storage.
  const ttsPath = `voice/${user.id}/${creation!.id}_mantra.mp3`;
  await supabase.storage
    .from('audio')
    .upload(ttsPath, ttsBuffer, { contentType: 'audio/mpeg' });

  // 5. Mix: in production, dispatch to a worker queue (e.g., Inngest or Trigger.dev)
  //    that handles FFmpeg mixing of frequency tone + soundscape + TTS track.
  //    For MVP, return the TTS URL directly as the output.
  const { data: { publicUrl } } = supabase.storage
    .from('audio')
    .getPublicUrl(ttsPath);

  // 6. Update creation record with output URL.
  await supabase
    .from('user_audio_creations')
    .update({ status: 'ready', output_url: publicUrl })
    .eq('id', creation!.id);

  // 7. Notify client via Realtime by updating the row (Realtime listens to the table).
  return new Response(
    JSON.stringify({ creation_id: creation!.id, output_url: publicUrl }),
    { headers: { 'Content-Type': 'application/json' } },
  );
});
```

### 5.2 `planetary-hours`

Calculates chaldean planetary hours for a given date and timezone.

```typescript
// supabase/functions/planetary-hours/index.ts
// Chaldean order: Sun, Venus, Mercury, Moon, Saturn, Jupiter, Mars
const CHALDEAN: string[] = ['Sun', 'Venus', 'Mercury', 'Moon', 'Saturn', 'Jupiter', 'Mars'];

interface PlanetaryHour {
  planet: string;
  start_time: string;    // ISO timestamp
  end_time: string;
  power_level: number;   // 1-5
  description: string;
  is_current: boolean;
}

serve(async (req) => {
  const url = new URL(req.url);
  const dateStr = url.searchParams.get('date') ?? new Date().toISOString().split('T')[0];
  const timezone = url.searchParams.get('timezone') ?? 'UTC';

  // Sunrise at ~6:00 AM local, sunset at ~18:00 — simplified for MVP.
  // Production: use SunCalc (npm:suncalc) for accurate sunrise/sunset per lat/lon.
  const dayHourMinutes = (18 * 60 - 6 * 60) / 12;     // ~60 min per day hour
  const nightHourMinutes = (24 * 60 - 12 * 60) / 12;  // ~60 min per night hour

  // Day ruler is determined by the day of week (0=Sun rules Sunday, etc.)
  const date = new Date(dateStr + 'T12:00:00Z');
  const dayRulerIndex = [0, 2, 4, 6, 1, 3, 5][date.getUTCDay()]; // Sun/Mon/Tue…
  const baseIndex = dayRulerIndex;

  const hours: PlanetaryHour[] = [];
  const now = new Date();
  const sunriseMs = new Date(dateStr + 'T06:00:00').getTime();

  for (let i = 0; i < 24; i++) {
    const planetIndex = (baseIndex + i) % 7;
    const startMs = sunriseMs + i * dayHourMinutes * 60_000;
    const endMs = startMs + dayHourMinutes * 60_000;
    hours.push({
      planet: CHALDEAN[planetIndex],
      start_time: new Date(startMs).toISOString(),
      end_time: new Date(endMs).toISOString(),
      power_level: [5, 4, 3, 2, 1, 3, 4][planetIndex],
      description: getPlanetDescription(CHALDEAN[planetIndex]),
      is_current: now.getTime() >= startMs && now.getTime() < endMs,
    });
  }

  return new Response(JSON.stringify(hours), {
    headers: { 'Content-Type': 'application/json' },
  });
});

function getPlanetDescription(planet: string): string {
  const map: Record<string, string> = {
    Sun:     'Liderazgo, vitalidad, propósito',
    Moon:    'Intuición, emociones, ciclos',
    Mars:    'Acción, energía, valentía',
    Mercury: 'Comunicación, mente, viajes',
    Jupiter: 'Abundancia, sabiduría, expansión',
    Venus:   'Amor, belleza, armonía',
    Saturn:  'Disciplina, karma, estructura',
  };
  return map[planet] ?? '';
}
```

### 5.3 `voice-clone`

Submits a voice recording to ElevenLabs for cloning.

```typescript
// supabase/functions/voice-clone/index.ts
serve(async (req) => {
  // Expects multipart/form-data with field "audio" (audio/webm or audio/mp4).
  const form = await req.formData();
  const audioFile = form.get('audio') as File;

  // Upload raw recording to Supabase Storage.
  const supabase = createClient( /* ... */ );
  const storagePath = `voice-clones/${userId}/${Date.now()}.webm`;
  await supabase.storage.from('voice-clones').upload(storagePath, audioFile);

  // Kick off ElevenLabs voice clone.
  const formData = new FormData();
  formData.append('name', `user_${userId}`);
  formData.append('files', audioFile, 'sample.webm');
  formData.append('description', 'Mantras user voice clone');

  const elResponse = await fetch('https://api.elevenlabs.io/v1/voices/add', {
    method: 'POST',
    headers: { 'xi-api-key': Deno.env.get('ELEVENLABS_API_KEY')! },
    body: formData,
  });
  const { voice_id } = await elResponse.json();

  // Persist the clone record.
  const { data } = await supabase
    .from('voice_clones')
    .insert({
      user_id: userId,
      elevenlabs_voice_id: voice_id,
      training_audio_url: storagePath,
      status: 'ready',
      quality_percent: 85,
    })
    .select('id')
    .single();

  return new Response(JSON.stringify({ clone_id: data!.id, voice_id }), {
    headers: { 'Content-Type': 'application/json' },
  });
});
```

### 5.4 `send-notification`

Sends FCM / APNs push notifications.

```typescript
// supabase/functions/send-notification/index.ts
// Called by: cron jobs (planetary hours), session reminder scheduler, and mirror hour triggers.

serve(async (req) => {
  const { user_id, type, title, body, data } = await req.json();

  const supabase = createClient( /* service role */ );

  // Fetch FCM tokens for user.
  const { data: tokens } = await supabase
    .from('device_tokens')
    .select('token, platform')
    .eq('user_id', user_id);

  // Check user preferences.
  const { data: prefs } = await supabase
    .from('notification_preferences')
    .select('*')
    .eq('user_id', user_id)
    .single();

  const prefKey = type as keyof typeof prefs;
  if (prefs && prefs[prefKey] === false) {
    return new Response(JSON.stringify({ skipped: true }));
  }

  // Send via FCM HTTP v1 API.
  const accessToken = await getFcmAccessToken();
  const projectId = Deno.env.get('FIREBASE_PROJECT_ID')!;

  await Promise.all(
    (tokens ?? []).map((device) =>
      fetch(
        `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`,
        {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${accessToken}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            message: {
              token: device.token,
              notification: { title, body },
              data,
              android: { priority: 'high' },
              apns: { headers: { 'apns-priority': '10' } },
            },
          }),
        },
      )
    ),
  );

  return new Response(JSON.stringify({ sent: tokens?.length ?? 0 }));
});
```

### 5.5 Cron Triggers (pg_cron)

```sql
-- Mirror hour notifications — runs every minute.
select cron.schedule(
  'mirror-hour-check',
  '* * * * *',
  $$
  select net.http_post(
    url := current_setting('app.edge_function_base') || '/functions/v1/mirror-hour-trigger',
    headers := '{"Authorization": "Bearer ' || current_setting('app.service_role_key') || '"}'::jsonb
  );
  $$
);

-- Daily planetary hours pre-calculation — runs at midnight UTC.
select cron.schedule(
  'planetary-hours-daily',
  '0 0 * * *',
  $$select net.http_post(url := '.../functions/v1/precompute-planetary-hours');$$
);
```

---

## 6. Flutter Integration Pattern

### 6.1 Service Layer Structure

```
lib/
├── services/
│   ├── api_service.dart            ← Supabase client wrapper (singleton)
│   ├── auth_service.dart           ← Supabase Auth (sign up, sign in, sign out)
│   ├── audio_service.dart          ← just_audio player (exists)
│   ├── storage_service.dart        ← Supabase Storage (upload/download)
│   ├── realtime_service.dart       ← Supabase Realtime subscriptions
│   └── notification_service.dart  ← FCM token registration + local notifications
│
├── models/
│   ├── user.dart
│   ├── meditation.dart
│   ├── collection.dart
│   ├── frequency.dart
│   ├── chakra.dart
│   ├── ritual.dart
│   ├── session.dart
│   ├── alarm.dart
│   └── achievement.dart
│
├── repositories/
│   ├── meditation_repository.dart
│   ├── session_repository.dart
│   ├── journal_repository.dart
│   └── subscription_repository.dart
│
└── providers/   (Riverpod)
    ├── auth_provider.dart
    ├── meditation_provider.dart
    ├── session_provider.dart
    └── subscription_provider.dart
```

### 6.2 `api_service.dart`

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  ApiService._();
  static final instance = ApiService._();

  SupabaseClient get client => Supabase.instance.client;

  // Typed fetch helper — throws on empty result.
  Future<T> fetchOne<T>({
    required String table,
    required Map<String, dynamic> filters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    dynamic query = client.from(table).select();
    for (final entry in filters.entries) {
      query = query.eq(entry.key, entry.value);
    }
    final data = await query.single() as Map<String, dynamic>;
    return fromJson(data);
  }

  Future<List<T>> fetchMany<T>({
    required String table,
    Map<String, dynamic> filters = const {},
    String? order,
    bool ascending = false,
    int? limit,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    dynamic query = client.from(table).select();
    for (final entry in filters.entries) {
      query = query.eq(entry.key, entry.value);
    }
    if (order != null) query = query.order(order, ascending: ascending);
    if (limit != null) query = query.limit(limit);
    final rows = await query as List<dynamic>;
    return rows.map((r) => fromJson(r as Map<String, dynamic>)).toList();
  }

  Future<Map<String, dynamic>> callFunction(
    String name, {
    Map<String, dynamic> body = const {},
  }) async {
    final response = await client.functions.invoke(name, body: body);
    return response.data as Map<String, dynamic>;
  }
}
```

### 6.3 Supabase Initialization (`main.dart`)

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,   // PKCE for mobile OAuth
    ),
  );

  runApp(const ProviderScope(child: App()));
}
```

### 6.4 Realtime — Alchemist audio completion

```dart
// In AlchemistScreen or a dedicated Riverpod notifier:
void _listenForAudioReady(String creationId) {
  final supabase = ApiService.instance.client;
  supabase
      .channel('audio_creation_$creationId')
      .onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'user_audio_creations',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'id',
          value: creationId,
        ),
        callback: (payload) {
          final row = payload.newRecord;
          if (row['status'] == 'ready') {
            final outputUrl = row['output_url'] as String;
            // Load into MantrasAudioService and play.
            MantrasAudioService.instance.playUrl(outputUrl);
          }
        },
      )
      .subscribe();
}
```

### 6.5 Required packages (`pubspec.yaml`)

```yaml
dependencies:
  supabase_flutter: ^2.5.0
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1
  just_audio: ^0.9.40          # already present
  firebase_messaging: ^15.0.0
  flutter_local_notifications: ^18.0.0
  purchases_flutter: ^6.0.0    # RevenueCat
  stripe_flutter: ^10.0.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0

dev_dependencies:
  riverpod_generator: ^2.6.1
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  build_runner: ^2.4.12
```

---

## 7. Environment Variables

Variables are injected at build time via `--dart-define` (Flutter) and as Supabase secrets (Edge Functions). Never commit actual values to source control.

### Flutter (`flutter build` / `flutter run`)

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://xxxx.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6... \
  --dart-define=REVENUECAT_APPLE_KEY=appl_xxxx \
  --dart-define=REVENUECAT_GOOGLE_KEY=goog_xxxx \
  --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_xxxx
```

Or via `.env` + a `dart_define_from_file` package for development.

### Supabase Edge Functions (`supabase secrets set`)

```
SUPABASE_URL=https://xxxx.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6...  (never expose to client)
ELEVENLABS_API_KEY=sk_xxxx
OPENAI_API_KEY=sk-xxxx
STRIPE_SECRET_KEY=sk_live_xxxx
STRIPE_WEBHOOK_SECRET=whsec_xxxx
FIREBASE_PROJECT_ID=mantras-app-prod
FIREBASE_SERVICE_ACCOUNT_JSON={"type":"service_account",...}
```

### Firebase (`google-services.json` / `GoogleService-Info.plist`)

Place platform files at:
- Android: `android/app/google-services.json`
- iOS: `ios/Runner/GoogleService-Info.plist`

These are excluded from source control via `.gitignore`. CI injects them as secrets.

---

## 8. Deployment Pipeline

### 8.1 Mobile (iOS + Android) via Fastlane

```
┌─ GitHub Actions ──────────────────────────────────────────┐
│  Trigger: push to main / release tag                       │
│                                                            │
│  1. flutter pub get                                        │
│  2. flutter test                                           │
│  3. flutter build ipa  --dart-define=...  (iOS)           │
│     fastlane pilot upload  →  App Store Connect            │
│                                                            │
│  4. flutter build appbundle  --dart-define=...  (Android)  │
│     fastlane supply  →  Google Play Internal Track         │
└────────────────────────────────────────────────────────────┘
```

**Fastlane `Matchfile`** manages code signing certificates via an encrypted git repo.

**Flavor matrix:**

| Flavor | Bundle ID | Supabase project | Stripe mode |
|---|---|---|---|
| `development` | `com.mantras.dev` | `xxxx-dev` | test keys |
| `staging` | `com.mantras.staging` | `xxxx-stg` | test keys |
| `production` | `com.mantras.app` | `xxxx-prod` | live keys |

### 8.2 Web via Vercel

```bash
flutter build web --release \
  --dart-define=SUPABASE_URL=$SUPABASE_URL \
  --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY

# Deploy /build/web to Vercel:
vercel --prod --cwd build/web
```

**Vercel configuration (`vercel.json`):**

```json
{
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "Cross-Origin-Opener-Policy", "value": "same-origin" },
        { "key": "Cross-Origin-Embedder-Policy", "value": "require-corp" }
      ]
    }
  ]
}
```

### 8.3 Supabase

```bash
# Install CLI
brew install supabase/tap/supabase

# Link project
supabase link --project-ref xxxx

# Apply migrations
supabase db push

# Deploy all Edge Functions
supabase functions deploy --project-ref xxxx

# Set production secrets
supabase secrets set ELEVENLABS_API_KEY=sk_xxxx --project-ref xxxx
```

**Migration file naming convention:** `supabase/migrations/YYYYMMDDHHMMSS_description.sql`

### 8.4 Storage Buckets

```sql
-- Create buckets via Supabase dashboard or CLI:
insert into storage.buckets (id, name, public)
values
  ('audio',        'audio',        false),   -- premium content, signed URLs
  ('images',       'images',       true),    -- thumbnails, covers
  ('voice-clones', 'voice-clones', false),   -- private user voice data
  ('user-creations','user-creations', false); -- private Alchemist outputs
```

**Storage RLS policy example:**

```sql
-- Users can only access their own voice-clone recordings.
create policy "voice-clones: owner access"
  on storage.objects for all
  using (
    bucket_id = 'voice-clones'
    and auth.uid()::text = (storage.foldername(name))[1]
  );
```

---

## 9. Cost Estimation

Estimates based on a growing user base of 1,000–10,000 monthly active users.

| Service | Plan | Monthly Cost |
|---|---|---|
| Supabase Pro | Up to 8 GB DB, 100 GB storage, 5M edge function invocations | $25 |
| Cloudflare R2 + Stream | 10 GB storage + 100 GB egress | ~$5–15 |
| ElevenLabs Starter | 30,000 characters/month TTS + 1 voice clone | $5 |
| ElevenLabs Creator | 100,000 characters/month + 3 clones (at scale) | $22 |
| Firebase (FCM) | Push notifications | Free |
| RevenueCat | Up to $2.5k MRR | Free |
| RevenueCat | $2.5k–$10k MRR | $119 |
| Stripe | 2.9% + $0.30 per web transaction | Variable |
| PostHog Cloud | Up to 1M events/month | Free |
| Vercel Pro (web) | Bandwidth + edge functions | $20 |
| **Total (MVP)** | | **~$55–85/month** |
| **Total (scale)** | | **~$200–400/month at 10k MAU** |

**Revenue model:**
- PRO Monthly: $9.99/month
- PRO Annual: $59.99/year (~50% discount)
- Break-even at approximately 10–15 paying subscribers

---

## 10. Implementation Roadmap

### Phase 1 — Foundation (Weeks 1–3)
- [ ] Provision Supabase project (dev + prod)
- [ ] Run schema migrations for users, subscriptions, meditations, collections
- [ ] Implement `ApiService` + `AuthService` in Flutter
- [ ] Replace mock/hardcoded data in tab screens with Supabase REST queries
- [ ] Upload first 10 meditation audio files to Supabase Storage
- [ ] Integrate RevenueCat for iOS + Android subscription management

### Phase 2 — Core Content (Weeks 4–6)
- [ ] Seed meditations, collections, chakras, frequencies, soundscapes tables
- [ ] Implement search endpoint (full-text via `plfts`)
- [ ] Wire PlayerScreen / PlayerEnhancedScreen to real `meditations` rows
- [ ] Build session guide profiles + booking flow backed by Supabase
- [ ] Implement gratitude journal and daily intention persistence

### Phase 3 — AI & Audio (Weeks 7–10)
- [ ] Deploy `generate-audio` Edge Function
- [ ] Wire Alchemist screen to `/functions/v1/generate-audio`
- [ ] Add Realtime listener for audio creation completion
- [ ] Deploy `voice-clone` Edge Function + ElevenLabs integration
- [ ] Implement progress polling in AlchemistScreen

### Phase 4 — Notifications & Astrology (Weeks 11–13)
- [ ] Integrate Firebase Messaging (FCM token registration)
- [ ] Deploy `send-notification` + `mirror-hour-trigger` Edge Functions
- [ ] Schedule pg_cron jobs for mirror hours and planetary hours
- [ ] Wire `planetary-hours` Edge Function to AstroTab
- [ ] Implement notification preferences screen persistence

### Phase 5 — Monetization & Launch (Weeks 14–16)
- [ ] Implement Stripe web checkout for subscription
- [ ] Set up Stripe webhook → `stripe-webhook` Edge Function
- [ ] Implement referral system (generate + redeem codes)
- [ ] Seed Tehilim chapters (150) with Hebrew + Spanish text
- [ ] Performance audit: query analysis, storage CDN caching, audio preload
- [ ] App Store + Google Play submission
