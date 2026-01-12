import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CheckInProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const CheckInProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: List.generate(
          totalSteps,
          (index) => Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index < totalSteps - 1 ? 8 : 0),
              decoration: BoxDecoration(
                color: index <= currentStep
                    ? AppColors.primary
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
