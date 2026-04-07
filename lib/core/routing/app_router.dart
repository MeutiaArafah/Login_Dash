import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/welcome_screen.dart';
import '../../features/home/presentation/home_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // If the authentication state is warming up (loading), stay on splash.
      if (authState.isLoading || !authState.hasValue) {
        return '/splash';
      }

      final isAuth = authState.value != null;
      final isLoggingIn = state.uri.path == '/welcome' || state.uri.path == '/login';
      final isSplash = state.uri.path == '/splash';

      if (isSplash) {
        return isAuth ? '/' : '/welcome';
      }

      if (!isAuth && !isLoggingIn) {
        // Unauthenticated, redirect to welcome gateway
        return '/welcome';
      }

      if (isAuth && isLoggingIn) {
        // Authenticated but on login screen, redirect to home
        return '/';
      }

      return null;
    },
  );
}
