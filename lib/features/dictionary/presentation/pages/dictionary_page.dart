import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/strings.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Gerçek dictionary data
    final terms = [
      {
        'term': 'Espresso',
        'definition':
            'A concentrated coffee brewed by forcing hot water through finely-ground coffee beans.',
      },
      {
        'term': 'Cappuccino',
        'definition':
            'An Italian coffee drink prepared with espresso, steamed milk, and milk foam.',
      },
      {
        'term': 'Latte',
        'definition': 'A coffee drink made with espresso and steamed milk.',
      },
      {
        'term': 'Macchiato',
        'definition': 'An espresso with a small amount of foamed milk.',
      },
      {
        'term': 'Americano',
        'definition':
            'Espresso with added hot water, giving it a similar strength to drip coffee.',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.coffeeDictionary),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: terms.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final term = terms[index];
          return _TermAccordion(
            term: term['term']!,
            definition: term['definition']!,
          );
        },
      ),
    );
  }
}

class _TermAccordion extends StatefulWidget {
  final String term;
  final String definition;

  const _TermAccordion({required this.term, required this.definition});

  @override
  State<_TermAccordion> createState() => _TermAccordionState();
}

class _TermAccordionState extends State<_TermAccordion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.term,
                      style: Theme.of(context).textTheme.titleMedium,
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
                    widget.definition,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
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
