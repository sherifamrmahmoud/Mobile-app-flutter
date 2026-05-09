// core/routing/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const Placeholder(),
    ),
  ],
);