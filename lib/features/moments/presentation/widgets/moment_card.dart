import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/moment.dart';

class MomentCard extends StatelessWidget {
  final Moment moment;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const MomentCard({
    super.key,
    required this.moment,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Drink name + time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.local_cafe_rounded,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                moment.recommendedDrinkName,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                DateFormatter.formatRelativeTime(
                                  moment.timestamp,
                                ),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textTertiary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.error,
                        size: 20,
                      ),
                      onPressed: onDelete,
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Mood indicators
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _MoodChip(
                    icon: _getEnergyIcon(moment.moodState.energy),
                    label: _getEnergyLabel(moment.moodState.energy),
                  ),
                  _MoodChip(
                    icon: _getMentalNeedIcon(moment.moodState.mentalNeed),
                    label: _getMentalNeedLabel(moment.moodState.mentalNeed),
                  ),
                ],
              ),

              // Taste profile
              if (moment.tasteProfile.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: moment.tasteProfile.take(3).map((taste) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.accent.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        taste,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              // AI Reflection (Premium)
              if (moment.aiReflection != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.premium.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.premium.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        size: 16,
                        color: AppColors.premium,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          moment.aiReflection!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontStyle: FontStyle.italic,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getEnergyIcon(energy) {
    switch (energy.toString()) {
      case 'EnergyLevel.low':
        return Icons.battery_2_bar_rounded;
      case 'EnergyLevel.high':
        return Icons.battery_full_rounded;
      default:
        return Icons.battery_5_bar_rounded;
    }
  }

  String _getEnergyLabel(energy) {
    switch (energy.toString()) {
      case 'EnergyLevel.low':
        return 'Low energy';
      case 'EnergyLevel.high':
        return 'High energy';
      default:
        return 'Balanced';
    }
  }

  IconData _getMentalNeedIcon(need) {
    switch (need.toString()) {
      case 'MentalNeed.focus':
        return Icons.center_focus_strong_rounded;
      case 'MentalNeed.slowDown':
        return Icons.self_improvement_rounded;
      default:
        return Icons.celebration_rounded;
    }
  }

  String _getMentalNeedLabel(need) {
    switch (need.toString()) {
      case 'MentalNeed.focus':
        return 'Focus';
      case 'MentalNeed.slowDown':
        return 'Relax';
      default:
        return 'Enjoy';
    }
  }
}

class _MoodChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MoodChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
