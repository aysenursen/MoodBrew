import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ExpandableWhy extends StatefulWidget {
  final String title;
  final String content;

  const ExpandableWhy({super.key, required this.title, required this.content});

  @override
  State<ExpandableWhy> createState() => _ExpandableWhyState();
}

class _ExpandableWhyState extends State<ExpandableWhy> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Icon(
                      _isExpanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                if (_isExpanded) ...[
                  const SizedBox(height: 12),
                  Text(
                    widget.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
