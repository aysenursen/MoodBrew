import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/strings.dart';
import '../../domain/entities/mood_state.dart';
import '../widgets/mood_option_card.dart';
import '../widgets/check_in_progress.dart';
import '../providers/check_in_provider.dart';
import 'package:go_router/go_router.dart';

class CheckInPage extends ConsumerWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkInState = ref.watch(checkInProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            CheckInProgress(currentStep: checkInState.currentStep),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildCurrentStep(context, ref, checkInState),
              ),
            ),

            // Back button
            if (checkInState.currentStep > 0)
              Padding(
                padding: const EdgeInsets.all(24),
                child: TextButton(
                  onPressed: () =>
                      ref.read(checkInProvider.notifier).previousStep(),
                  child: const Text('Back'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep(
    BuildContext context,
    WidgetRef ref,
    CheckInState state,
  ) {
    switch (state.currentStep) {
      case 0:
        return _buildEnergyStep(context, ref);
      case 1:
        return _buildMentalNeedStep(context, ref);
      case 2:
        return _buildRiskMoodStep(context, ref);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildEnergyStep(BuildContext context, WidgetRef ref) {
    return _StepLayout(
      key: const ValueKey('energy'),
      question: AppStrings.energyQuestion,
      options: [
        MoodOptionCard(
          label: AppStrings.energyLow,
          icon: Icons.battery_2_bar_rounded,
          color: AppColors.moodLow,
          onTap: () {
            ref.read(checkInProvider.notifier).setEnergy(EnergyLevel.low);
          },
        ),
        MoodOptionCard(
          label: AppStrings.energyOkay,
          icon: Icons.battery_5_bar_rounded,
          color: AppColors.moodOkay,
          onTap: () {
            ref.read(checkInProvider.notifier).setEnergy(EnergyLevel.okay);
          },
        ),
        MoodOptionCard(
          label: AppStrings.energyHigh,
          icon: Icons.battery_full_rounded,
          color: AppColors.moodHigh,
          onTap: () {
            ref.read(checkInProvider.notifier).setEnergy(EnergyLevel.high);
          },
        ),
      ],
    );
  }

  Widget _buildMentalNeedStep(BuildContext context, WidgetRef ref) {
    return _StepLayout(
      key: const ValueKey('mental'),
      question: AppStrings.mentalNeedQuestion,
      options: [
        MoodOptionCard(
          label: AppStrings.mentalNeedFocus,
          icon: Icons.center_focus_strong_rounded,
          color: AppColors.primary,
          onTap: () {
            ref.read(checkInProvider.notifier).setMentalNeed(MentalNeed.focus);
          },
        ),
        MoodOptionCard(
          label: AppStrings.mentalNeedSlowDown,
          icon: Icons.self_improvement_rounded,
          color: AppColors.moodLow,
          onTap: () {
            ref
                .read(checkInProvider.notifier)
                .setMentalNeed(MentalNeed.slowDown);
          },
        ),
        MoodOptionCard(
          label: AppStrings.mentalNeedEnjoy,
          icon: Icons.celebration_rounded,
          color: AppColors.accent,
          onTap: () {
            ref.read(checkInProvider.notifier).setMentalNeed(MentalNeed.enjoy);
          },
        ),
      ],
    );
  }

  Widget _buildRiskMoodStep(BuildContext context, WidgetRef ref) {
    return _StepLayout(
      key: const ValueKey('risk'),
      question: AppStrings.riskMoodQuestion,
      options: [
        MoodOptionCard(
          label: AppStrings.riskMoodFamiliar,
          icon: Icons.favorite_rounded,
          color: AppColors.textSecondary,
          onTap: () {
            ref.read(checkInProvider.notifier).setRiskMood(RiskMood.familiar);
            _navigateToReflection(context, ref);
          },
        ),
        MoodOptionCard(
          label: AppStrings.riskMoodSlightlyDifferent,
          icon: Icons.explore_rounded,
          color: AppColors.primary,
          onTap: () {
            ref
                .read(checkInProvider.notifier)
                .setRiskMood(RiskMood.slightlyDifferent);
            _navigateToReflection(context, ref);
          },
        ),
        MoodOptionCard(
          label: AppStrings.riskMoodSurpriseMe,
          icon: Icons.auto_awesome_rounded,
          color: AppColors.accent,
          onTap: () {
            ref.read(checkInProvider.notifier).setRiskMood(RiskMood.surpriseMe);
            _navigateToReflection(context, ref);
          },
        ),
      ],
    );
  }

  void _navigateToReflection(BuildContext context, WidgetRef ref) {
    final moodState = ref.read(checkInProvider).toMoodState();
    if (moodState != null) {
      context.push('/reflection', extra: moodState);
    }
  }
}

class _StepLayout extends StatelessWidget {
  final String question;
  final List<Widget> options;

  const _StepLayout({super.key, required this.question, required this.options});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ...options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: option,
            ),
          ),
        ],
      ),
    );
  }
}
