import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/onboarding_flow.dart';
import 'screens/home_screen.dart';
import 'screens/marketplace_screen.dart';
import 'screens/mirror_hours_screen.dart';
import 'screens/notif_lock_screen.dart';
import 'screens/notif_banner_screen.dart';
import 'screens/notif_modal_screen.dart';
import 'screens/alchemist_screen.dart';
import 'screens/player_screen.dart';
import 'screens/collections_screen.dart';
import 'screens/sleep_screen.dart';
import 'screens/library_screen.dart';
import 'screens/healing_screen.dart';
import 'screens/sessions_screen.dart';
import 'screens/book_session_screen.dart';
import 'screens/sound_library_screen.dart';
import 'screens/more_collections_screen.dart';
import 'screens/agenda_screen.dart';
import 'screens/notifications_settings_screen.dart';
import 'screens/language_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/my_profile_screen.dart';
import 'screens/new_alarm_screen.dart';
import 'screens/achievements_screen.dart';
import 'screens/invite_friends_screen.dart';
// Screens 43-49
import 'screens/subscription_screen.dart';
import 'screens/customer_center_screen.dart';
import 'screens/player_enhanced_screen.dart';
import 'screens/chakras_screen.dart';
import 'screens/lunar_rituals_screen.dart';
import 'screens/manifestation_screen.dart';
import 'screens/sacred_frequencies_screen.dart';
// Extra screens
import 'screens/daily_ritual_screen.dart';
import 'screens/search_screen.dart';
import 'screens/playlist_detail_screen.dart';
import 'screens/gratitude_journal_screen.dart';
import 'screens/tehilim_screen.dart';
// Silva method screens
import 'screens/silva_hub_screen.dart';
import 'screens/silva_alfa_screen.dart';
import 'screens/silva_mirror_screen.dart';
import 'screens/silva_water_screen.dart';
import 'screens/silva_fingers_screen.dart';
import 'screens/silva_lab_screen.dart';
import 'screens/silva_screen_mental.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: '/intro',
      builder: (BuildContext context, GoRouterState state) =>
          const IntroScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (BuildContext context, GoRouterState state) =>
          const OnboardingFlow(),
    ),
    // Main shell — manages its own 5-tab bottom nav internally.
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    // Sub-screens — pushed on top with no bottom nav.
    GoRoute(
      path: '/marketplace',
      builder: (BuildContext context, GoRouterState state) =>
          const MarketplaceScreen(),
    ),
    GoRoute(
      path: '/mirror-hours',
      builder: (BuildContext context, GoRouterState state) =>
          const MirrorHoursScreen(),
    ),
    GoRoute(
      path: '/notif-lock',
      builder: (BuildContext context, GoRouterState state) =>
          const NotifLockScreen(),
    ),
    GoRoute(
      path: '/notif-banner',
      builder: (BuildContext context, GoRouterState state) =>
          const NotifBannerScreen(),
    ),
    GoRoute(
      path: '/notif-modal',
      builder: (BuildContext context, GoRouterState state) =>
          const NotifModalScreen(),
    ),
    GoRoute(
      path: '/alchemist',
      builder: (BuildContext context, GoRouterState state) =>
          const AlchemistScreen(),
    ),
    GoRoute(
      path: '/player',
      builder: (_, __) => const PlayerScreen(),
    ),
    GoRoute(
      path: '/collections',
      builder: (_, __) => const CollectionsScreen(),
    ),
    GoRoute(
      path: '/sleep',
      builder: (_, __) => const SleepScreen(),
    ),
    GoRoute(
      path: '/library',
      builder: (_, __) => const LibraryScreen(),
    ),
    GoRoute(
      path: '/healing',
      builder: (_, __) => const HealingScreen(),
    ),
    GoRoute(path: '/sessions', builder: (_, __) => const SessionsScreen()),
    GoRoute(
      path: '/book-session',
      builder: (_, __) => const BookSessionScreen(),
    ),
    GoRoute(
      path: '/sound-library',
      builder: (_, __) => const SoundLibraryScreen(),
    ),
    GoRoute(
      path: '/more-collections',
      builder: (_, __) => const MoreCollectionsScreen(),
    ),
    GoRoute(path: '/agenda', builder: (_, __) => const AgendaScreen()),
    // Settings / profile sub-screens
    GoRoute(
      path: '/notifications-settings',
      builder: (_, __) => const NotificationsSettingsScreen(),
    ),
    GoRoute(path: '/language', builder: (_, __) => const LanguageScreen()),
    GoRoute(path: '/terms', builder: (_, __) => const TermsScreen()),
    GoRoute(path: '/my-profile', builder: (_, __) => const MyProfileScreen()),
    GoRoute(path: '/new-alarm', builder: (_, __) => const NewAlarmScreen()),
    GoRoute(
      path: '/achievements',
      builder: (_, __) => const AchievementsScreen(),
    ),
    GoRoute(path: '/invite', builder: (_, __) => const InviteFriendsScreen()),
    // ── Screens 43-49 ─────────────────────────────────────────────────────
    GoRoute(
      path: '/subscription',
      builder: (_, __) => const SubscriptionScreen(),
    ),
    GoRoute(
      path: '/customer-center',
      builder: (_, __) => const CustomerCenterScreen(),
    ),
    GoRoute(
      path: '/player-enhanced',
      builder: (_, __) => const PlayerEnhancedScreen(),
    ),
    GoRoute(
      path: '/chakras',
      builder: (_, __) => const ChakrasScreen(),
    ),
    GoRoute(
      path: '/lunar-rituals',
      builder: (_, __) => const LunarRitualsScreen(),
    ),
    GoRoute(
      path: '/manifestation',
      builder: (_, __) => const ManifestationScreen(),
    ),
    GoRoute(
      path: '/sacred-frequencies',
      builder: (_, __) => const SacredFrequenciesScreen(),
    ),
    // ── Extra UX screens ──────────────────────────────────────────────────
    GoRoute(
      path: '/daily-ritual',
      builder: (_, __) => const DailyRitualScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (_, __) => const SearchScreen(),
    ),
    GoRoute(
      path: '/playlist-detail',
      builder: (_, __) => const PlaylistDetailScreen(),
    ),
    GoRoute(
      path: '/gratitude-journal',
      builder: (_, __) => const GratitudeJournalScreen(),
    ),
    GoRoute(
      path: '/tehilim',
      builder: (_, __) => const TehilimScreen(),
    ),
    // ── Método Silva ──────────────────────────────────────────────────
    GoRoute(path: '/silva', builder: (_, __) => const SilvaHubScreen()),
    GoRoute(path: '/silva/alfa', builder: (_, __) => const SilvaAlfaScreen()),
    GoRoute(
        path: '/silva/mirror', builder: (_, __) => const SilvaMirrorScreen()),
    GoRoute(
        path: '/silva/water', builder: (_, __) => const SilvaWaterScreen()),
    GoRoute(
        path: '/silva/fingers',
        builder: (_, __) => const SilvaFingersScreen()),
    GoRoute(path: '/silva/lab', builder: (_, __) => const SilvaLabScreen()),
    GoRoute(
        path: '/silva/screen',
        builder: (_, __) => const SilvaScreenMentalScreen()),
  ],
);
