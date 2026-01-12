import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/strings.dart';
import '../../domain/entities/recommendation.dart';
import '../widgets/drink_card.dart';
import '../widgets/expandable_why.dart';
import '../widgets/fun_fact_card.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class RecommendationPage extends ConsumerWidget {
  final Recommendation recommendation;

  const RecommendationPage({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
                onPressed: () => context.go('/'),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Drink card
                  DrinkCard(drink: recommendation.drink),

                  const SizedBox(height: 24),

                  // Emotional description
                  Text(
                    recommendation.emotionalDescription,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Taste profile chips
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: recommendation.tasteProfile.map((taste) {
                      return Chip(
                        label: Text(taste),
                        backgroundColor: AppColors.surfaceVariant,
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 32),

                  // Expandable "Why this works"
                  ExpandableWhy(
                    title: AppStrings.whyThisWorks,
                    content: recommendation.drink.whyThisWorks,
                  ),

                  const SizedBox(height: 24),

                  // Fun fact
                  FunFactCard(funFact: recommendation.funFact),

                  const SizedBox(height: 32),

                  // Save moment button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          _handleSaveMoment(context, ref, authState),
                      icon: const Icon(Icons.bookmark_border_rounded),
                      label: const Text(AppStrings.saveMoment),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Start new check-in
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go('/check-in'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(AppStrings.newCheckIn),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSaveMoment(
    BuildContext context,
    WidgetRef ref,
    AsyncValue authState,
  ) {
    authState.when(
      data: (user) {
        if (user == null) {
          // Üye değilse auth gate'e yönlendir
          context.push(
            '/auth-gate',
            extra: () {
              // Auth başarılı olduktan sonra moment'i kaydet
              _saveMoment(ref);
            },
          );
        } else {
          // Üyeyse direkt kaydet
          _saveMoment(ref);
        }
      },
      loading: () {},
      error: (_, __) {},
    );
  }

  void _saveMoment(WidgetRef ref) {
    // TODO: Implement save moment logic
    // SaveMoment use case'i çağrılacak
  }
}
