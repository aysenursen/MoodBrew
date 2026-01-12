import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../check_in/domain/entities/mood_state.dart';
import '../../../recommendation/domain/usecases/get_recommendation.dart';
import '../../data/datasources/reflection_generator.dart';
import '../../../../injection_container.dart';

class ReflectionPage extends ConsumerStatefulWidget {
  final MoodState moodState;

  const ReflectionPage({super.key, required this.moodState});

  @override
  ConsumerState<ReflectionPage> createState() => _ReflectionPageState();
}

class _ReflectionPageState extends ConsumerState<ReflectionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Otomatik olarak recommendation'a geç (2 saniye sonra)
    Future.delayed(const Duration(seconds: 2), _navigateToRecommendation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateToRecommendation() async {
    final getRecommendation = sl<GetRecommendation>();
    final result = await getRecommendation(widget.moodState);

    result.fold(
      (failure) {
        // Error handling
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (recommendation) {
        if (mounted) {
          context.pushReplacement('/recommendation', extra: recommendation);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final generator = sl<ReflectionGenerator>();
    final reflectionText = generator.generateReflectionText(widget.moodState);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      // Reflection icon
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.self_improvement_rounded,
                          size: 64,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Reflection text
                      Text(
                        reflectionText,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: AppColors.textPrimary,
                              height: 1.5,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 48),

                      // Loading indicator
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
