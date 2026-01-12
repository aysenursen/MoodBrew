import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/strings.dart';
import '../widgets/auth_button.dart';
import '../providers/auth_provider.dart';

class AuthGatePage extends ConsumerWidget {
  final VoidCallback? onAuthSuccess;

  const AuthGatePage({super.key, this.onAuthSuccess});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bookmark_border_rounded,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              Text(
                AppStrings.wantToSaveThisMoment,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Auth buttons
              AuthButton(
                icon: Icons.g_mobiledata_rounded,
                label: AppStrings.continueWithGoogle,
                color: Colors.white,
                textColor: AppColors.textPrimary,
                onPressed: () => _handleGoogleSignIn(context, ref),
              ),

              const SizedBox(height: 16),

              AuthButton(
                icon: Icons.apple_rounded,
                label: AppStrings.continueWithApple,
                color: AppColors.textPrimary,
                textColor: Colors.white,
                onPressed: () => _handleAppleSignIn(context, ref),
              ),

              const SizedBox(height: 16),

              AuthButton(
                icon: Icons.email_outlined,
                label: AppStrings.continueWithEmail,
                color: AppColors.surface,
                textColor: AppColors.textPrimary,
                onPressed: () => _handleEmailSignIn(context, ref),
              ),

              const SizedBox(height: 32),

              // Skip text
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  AppStrings.noAccountNeeded,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn(BuildContext context, WidgetRef ref) async {
    final result = await ref
        .read(authControllerProvider.notifier)
        .signInWithGoogle();

    result.fold(
      (failure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (user) {
        onAuthSuccess?.call();
        context.pop();
      },
    );
  }

  Future<void> _handleAppleSignIn(BuildContext context, WidgetRef ref) async {
    // TODO: Implement Apple Sign In
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Apple Sign In coming soon')));
  }

  Future<void> _handleEmailSignIn(BuildContext context, WidgetRef ref) async {
    // TODO: Implement Email Sign In
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Email Sign In coming soon')));
  }
}
