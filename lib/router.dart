import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/onboarding_flow.dart';
import 'screens/home_screen.dart';
import 'screens/marketplace_screen.dart';
import 'screens/mirror_hours_screen.dart';

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
  ],
);
