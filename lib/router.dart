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
    GoRoute(path: '/book-session', builder: (_, __) => const BookSessionScreen()),
    GoRoute(path: '/sound-library', builder: (_, __) => const SoundLibraryScreen()),
    GoRoute(path: '/more-collections', builder: (_, __) => const MoreCollectionsScreen()),
    GoRoute(path: '/agenda', builder: (_, __) => const AgendaScreen()),
  ],
);
