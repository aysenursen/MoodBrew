import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/recommendation.dart';
import '../../../check_in/domain/entities/mood_state.dart';

abstract class RecommendationRepository {
  Future<Either<Failure, Recommendation>> getRecommendation(
    MoodState moodState,
  );
  Future<Either<Failure, String>> getFunFact(List<String> tags);
}
