import 'package:dartz/dartz.dart';
import 'package:moodbrew/core/usecases/usecase.dart' show UseCase;
import '../../../../core/error/failures.dart';
import '../entities/recommendation.dart';
import '../repositories/recommendation_repository.dart';
import '../../../check_in/domain/entities/mood_state.dart';

class GetRecommendation implements UseCase<Recommendation, MoodState> {
  final RecommendationRepository repository;

  GetRecommendation(this.repository);

  @override
  Future<Either<Failure, Recommendation>> call(MoodState moodState) async {
    return await repository.getRecommendation(moodState);
  }
}
