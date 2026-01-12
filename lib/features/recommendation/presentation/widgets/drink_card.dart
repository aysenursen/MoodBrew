import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/drink.dart';

class DrinkCard extends StatelessWidget {
  final Drink drink;

  const DrinkCard({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // Image placeholder
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.local_cafe_rounded,
              size: 80,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 24),

          // Drink name
          Text(
            drink.name,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Drink description
          Text(
            drink.description,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
