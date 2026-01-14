import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodbrew/features/auth/presentation/pages/email_auth_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/check_in/presentation/pages/check_in_page.dart';
import '../../features/reflection/presentation/pages/reflection_page.dart';
import '../../features/recommendation/presentation/pages/recommendation_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/auth_gate_page.dart';
import '../../features/dictionary/presentation/pages/dictionary_page.dart';
import '../../features/premium/presentation/pages/premium_page.dart';
import '../../features/moments/presentation/pages/moments_timeline_page.dart';
import '../../features/check_in/domain/entities/mood_state.dart';
import '../../features/recommendation/domain/entities/recommendation.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),
      GoRoute(
        path: '/check-in',
        builder: (context, state) => const CheckInPage(),
      ),
      GoRoute(
        path: '/reflection',
        builder: (context, state) {
          final moodState = state.extra as MoodState;
          return ReflectionPage(moodState: moodState);
        },
      ),
      GoRoute(
        path: '/recommendation',
        builder: (context, state) {
          final recommendation = state.extra as Recommendation;
          return RecommendationPage(recommendation: recommendation);
        },
      ),
      GoRoute(
        path: '/auth-gate',
        builder: (context, state) {
          final onAuthSuccess = state.extra as VoidCallback?;
          return AuthGatePage(onAuthSuccess: onAuthSuccess);
        },
      ),
      GoRoute(
        path: '/email-auth',
        builder: (context, state) {
          final onAuthSuccess = state.extra as VoidCallback?;
          return EmailAuthPage(onAuthSuccess: onAuthSuccess);
        },
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/moments',
        builder: (context, state) => const MomentsTimelinePage(),
      ),
      GoRoute(
        path: '/dictionary',
        builder: (context, state) => const DictionaryPage(),
      ),
      GoRoute(
        path: '/premium',
        builder: (context, state) => const PremiumPage(),
      ),
    ],
  );
});
