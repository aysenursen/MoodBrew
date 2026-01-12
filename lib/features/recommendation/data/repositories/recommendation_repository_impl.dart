import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/repositories/recommendation_repository.dart';
import '../../../check_in/domain/entities/mood_state.dart';
import '../datasources/drinks_local_data_source.dart';
import '../datasources/recommendation_engine.dart';
import '../../../reflection/data/datasources/reflection_generator.dart';

class RecommendationRepositoryImpl implements RecommendationRepository {
  final DrinksLocalDataSource drinksDataSource;
  final RecommendationEngine engine;
  final ReflectionGenerator reflectionGenerator;

  RecommendationRepositoryImpl({
    required this.drinksDataSource,
    required this.engine,
    required this.reflectionGenerator,
  });

  @override
  Future<Either<Failure, Recommendation>> getRecommendation(
    MoodState moodState,
  ) async {
    try {
      // 1. Önce içeceği seç
      final drink = engine.getRecommendation(moodState);

      // 2. Duygusal açıklama oluştur
      final emotionalDescription = reflectionGenerator
          .generateEmotionalDescription(drink, moodState);

      // 3. Tat profili oluştur
      final tasteProfile = reflectionGenerator.generateTasteProfile(
        drink,
        moodState,
      );

      // 4. Fun fact getir
      final funFact = await _getFunFact(drink.tasteProfile);

      return Right(
        Recommendation(
          drink: drink,
          emotionalDescription: emotionalDescription,
          funFact: funFact,
          tasteProfile: tasteProfile,
        ),
      );
    } on CacheException {
      return const Left(CacheFailure('Could not get recommendation'));
    }
  }

  @override
  Future<Either<Failure, String>> getFunFact(List<String> tags) async {
    try {
      final funFact = await _getFunFact(tags);
      return Right(funFact);
    } on CacheException {
      return const Left(CacheFailure('Could not get fun fact'));
    }
  }

  Future<String> _getFunFact(List<String> tags) async {
    // JSON'dan ilgili fun fact'i getir
    // Şimdilik basit bir implementasyon
    final funFacts = [
      'The word "coffee" comes from the Arabic word "qahwa".',
      'A coffee tree can live up to 100 years.',
      'Finland consumes the most coffee per capita in the world.',
      'Coffee is actually a fruit - it grows on trees as cherries.',
      'Espresso means "pressed out" in Italian.',
    ];

    return funFacts[DateTime.now().second % funFacts.length];
  }
}
