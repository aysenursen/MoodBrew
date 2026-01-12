import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class FunFactCard extends StatelessWidget {
  final String funFact;

  const FunFactCard({super.key, required this.funFact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent.withOpacity(0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: AppColors.accent,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              funFact,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
