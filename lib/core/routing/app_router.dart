import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/profile/ui/profile_screen.dart'; 

import 'routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/profile',
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const Placeholder(), 
    ),
    GoRoute(
      path: Routes.login,
      name: 'login',
      builder: (context, state) => const Placeholder(), 
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const Placeholder(),
    ),
   
    GoRoute(
      path: '/profile', 
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);