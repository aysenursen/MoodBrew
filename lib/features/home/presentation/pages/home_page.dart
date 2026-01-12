import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('MoodBrew'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person_outline_rounded),
                  onPressed: () {
                    // Profile sayfası
                  },
                ),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Welcome message
                  authState.when(
                    data: (user) => Text(
                      user != null
                          ? 'Welcome back, ${user.displayName ?? "there"}!'
                          : 'Welcome!',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),

                  const SizedBox(height: 32),

                  // New Check-in Button
                  _NewCheckInCard(onTap: () => context.push('/check-in')),

                  const SizedBox(height: 24),

                  // Premium Teaser (if not premium)
                  authState.when(
                    data: (user) {
                      if (user == null || !user.isPremium) {
                        return _PremiumTeaser(
                          onTap: () => context.push('/premium'),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),

                  const SizedBox(height: 32),

                  // Section title
                  Text(
                    AppStrings.savedMoments,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 16),

                  // Saved moments preview
                  authState.when(
                    data: (user) {
                      if (user == null) {
                        return _SignInPrompt(
                          onTap: () => context.push('/auth-gate'),
                        );
                      }
                      return _MomentsPreview(
                        onTap: () => context.push('/moments'),
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Text('Error loading moments'),
                  ),

                  const SizedBox(height: 32),

                  // Dictionary button
                  ListTile(
                    leading: const Icon(Icons.menu_book_rounded),
                    title: const Text(AppStrings.coffeeDictionary),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: () => context.push('/dictionary'),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewCheckInCard extends StatelessWidget {
  final VoidCallback onTap;

  const _NewCheckInCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                size: 64,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.newCheckIn,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'How are you feeling today?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PremiumTeaser extends StatelessWidget {
  final VoidCallback onTap;

  const _PremiumTeaser({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.premium.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.premium.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.premium,
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Try Premium',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'AI-powered insights & more',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.premium,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  final VoidCallback onTap;

  const _SignInPrompt({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size: 48,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Sign in to save your moments',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onTap, child: const Text('Sign In')),
        ],
      ),
    );
  }
}

class _MomentsPreview extends StatelessWidget {
  final VoidCallback onTap;

  const _MomentsPreview({required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: Gerçek moment'leri göster
    return Column(
      children: [
        _MomentPreviewCard(
          drinkName: 'Cappuccino',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          mood: 'Feeling balanced',
        ),
        const SizedBox(height: 12),
        _MomentPreviewCard(
          drinkName: 'Espresso',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          mood: 'Need focus',
        ),
        const SizedBox(height: 16),
        TextButton(onPressed: onTap, child: const Text('View all moments')),
      ],
    );
  }
}

class _MomentPreviewCard extends StatelessWidget {
  final String drinkName;
  final DateTime timestamp;
  final String mood;

  const _MomentPreviewCard({
    required this.drinkName,
    required this.timestamp,
    required this.mood,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.local_cafe_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(drinkName, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  mood,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatTime(timestamp),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }
}
