import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/strings.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    // Premium icon
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.premium,
                              AppColors.premium.withOpacity(0.7),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.auto_awesome_rounded,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Title
                    Text(
                      'Upgrade to Premium',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 48),

                    // Features
                    _FeatureCard(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: AppStrings.talkInsteadOfTapping,
                      description:
                          'Express your mood naturally with AI-powered text input',
                    ),

                    const SizedBox(height: 16),

                    _FeatureCard(
                      icon: Icons.psychology_outlined,
                      title: AppStrings.deeperReflections,
                      description:
                          'Get personalized insights about your coffee journey',
                    ),

                    const SizedBox(height: 16),

                    _FeatureCard(
                      icon: Icons.auto_fix_high_rounded,
                      title: AppStrings.personalizedExplanations,
                      description:
                          'Understand why each recommendation fits your mood',
                    ),
                  ],
                ),
              ),

              // Upgrade button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement payment
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.premium,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(AppStrings.upgradeToPremium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.premium.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.premium),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
