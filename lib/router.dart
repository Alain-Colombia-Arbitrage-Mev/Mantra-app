import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/intro_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/onboarding_flow.dart';
import 'screens/home_screen.dart';
import 'widgets/pencil_surface.dart';
// Extra screens
import 'screens/daily_ritual_screen.dart';
import 'screens/search_screen.dart';
import 'screens/playlist_detail_screen.dart';
import 'screens/gratitude_journal_screen.dart';
import 'screens/tehilim_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/intro',
  routes: [
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) => '/intro',
    ),
    GoRoute(
      path: '/intro',
      builder: (BuildContext context, GoRouterState state) =>
          const IntroScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterScreen(),
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
          const PencilSurface(nodeId: '4zyNc'),
    ),
    GoRoute(
      path: '/mirror-hours',
      builder: (BuildContext context, GoRouterState state) =>
          const PencilSurface(nodeId: 'en72P'),
    ),
    GoRoute(
      path: '/notif-lock',
      builder: (BuildContext context, GoRouterState state) =>
          const PencilSurface(nodeId: 'ByUBv'),
    ),
    GoRoute(
      path: '/notif-banner',
      builder: (BuildContext context, GoRouterState state) =>
          const PencilSurface(nodeId: 'X4Ud9'),
    ),
    GoRoute(
      path: '/notif-modal',
      builder: (BuildContext context, GoRouterState state) =>
          const PencilSurface(nodeId: '6Jq4L'),
    ),
    GoRoute(
      path: '/alchemist',
      builder: (BuildContext context, GoRouterState state) =>
          const PencilSurface(nodeId: 'PMKRr'),
    ),
    GoRoute(
      path: '/player',
      builder: (_, _) => const PencilSurface(nodeId: 'Hfb28'),
    ),
    GoRoute(
      path: '/collections',
      builder: (_, _) => const PencilSurface(nodeId: 'xWUog'),
    ),
    GoRoute(
      path: '/sleep',
      builder: (_, _) => const PencilSurface(nodeId: 'jZS4y'),
    ),
    GoRoute(
      path: '/library',
      builder: (_, _) => const PencilSurface(nodeId: 'hyNV0'),
    ),
    GoRoute(
      path: '/healing',
      builder: (_, _) => const PencilSurface(nodeId: 'p2H6x0'),
    ),
    GoRoute(
      path: '/sessions',
      builder: (_, _) => const PencilSurface(nodeId: '166L4'),
    ),
    GoRoute(
      path: '/book-session',
      builder: (_, _) => const PencilSurface(nodeId: 'Cv19w'),
    ),
    GoRoute(
      path: '/sound-library',
      builder: (_, _) => const PencilSurface(nodeId: 'vt8vT'),
    ),
    GoRoute(
      path: '/more-collections',
      builder: (_, _) => const PencilSurface(nodeId: 'Ln20z'),
    ),
    GoRoute(
      path: '/agenda',
      builder: (_, _) => const PencilSurface(nodeId: 'yJR10'),
    ),
    // Settings / profile sub-screens
    GoRoute(
      path: '/notifications-settings',
      builder: (_, _) => const PencilSurface(nodeId: 'mvWGF'),
    ),
    GoRoute(
      path: '/language',
      builder: (_, _) => const PencilSurface(nodeId: 'cDNKl'),
    ),
    GoRoute(
      path: '/terms',
      builder: (_, _) => const PencilSurface(nodeId: 'Xoczg'),
    ),
    GoRoute(
      path: '/my-profile',
      builder: (_, _) => const PencilSurface(nodeId: 'ry8mw'),
    ),
    GoRoute(
      path: '/new-alarm',
      builder: (_, _) => const PencilSurface(nodeId: 'vEB3h'),
    ),
    GoRoute(
      path: '/achievements',
      builder: (_, _) => const PencilSurface(nodeId: 'FVkTd'),
    ),
    GoRoute(
      path: '/invite',
      builder: (_, _) => const PencilSurface(nodeId: 'F5HWa'),
    ),
    // ── Screens 43-49 ─────────────────────────────────────────────────────
    GoRoute(
      path: '/subscription',
      builder: (_, _) => const PencilSurface(nodeId: 'HREeu'),
    ),
    GoRoute(
      path: '/customer-center',
      builder: (_, _) => const PencilSurface(nodeId: 'FWVMW'),
    ),
    GoRoute(
      path: '/player-enhanced',
      builder: (_, _) => const PencilSurface(nodeId: 'cDcnq'),
    ),
    GoRoute(
      path: '/chakras',
      builder: (_, _) => const PencilSurface(nodeId: 'd5uRt'),
    ),
    GoRoute(
      path: '/lunar-rituals',
      builder: (_, _) => const PencilSurface(nodeId: 'KBMs1'),
    ),
    GoRoute(
      path: '/manifestation',
      builder: (_, _) => const PencilSurface(nodeId: 'pTZ13'),
    ),
    GoRoute(
      path: '/sacred-frequencies',
      builder: (_, _) => const PencilSurface(nodeId: 'V6BE1'),
    ),
    // ── Extra UX screens ──────────────────────────────────────────────────
    GoRoute(
      path: '/daily-ritual',
      builder: (_, _) => const DailyRitualScreen(),
    ),
    GoRoute(path: '/search', builder: (_, _) => const SearchScreen()),
    GoRoute(
      path: '/playlist-detail',
      builder: (_, _) => const PlaylistDetailScreen(),
    ),
    GoRoute(
      path: '/gratitude-journal',
      builder: (_, _) => const GratitudeJournalScreen(),
    ),
    GoRoute(path: '/tehilim', builder: (_, _) => const TehilimScreen()),
    // ── Método Silva ──────────────────────────────────────────────────
    GoRoute(
      path: '/silva',
      builder: (_, _) => const PencilSurface(nodeId: 'GG1Ls'),
    ),
    GoRoute(
      path: '/silva/alfa',
      builder: (_, _) => const PencilSurface(nodeId: '73J5a'),
    ),
    GoRoute(
      path: '/silva/mirror',
      builder: (_, _) => const PencilSurface(nodeId: 'W1Xa8'),
    ),
    GoRoute(
      path: '/silva/water',
      builder: (_, _) => const PencilSurface(nodeId: 'WfPND'),
    ),
    GoRoute(
      path: '/silva/fingers',
      builder: (_, _) => const PencilSurface(nodeId: 'lsacg'),
    ),
    GoRoute(
      path: '/silva/lab',
      builder: (_, _) => const PencilSurface(nodeId: 'oXpqC'),
    ),
    GoRoute(
      path: '/silva/screen',
      builder: (_, _) => const PencilSurface(nodeId: 'LO9Op'),
    ),
  ],
);
