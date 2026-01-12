import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart' show UseCase;
import '../entities/moment.dart';
import '../repositories/moments_repository.dart';

class SaveMoment implements UseCase<Moment, SaveMomentParams> {
  final MomentsRepository repository;

  SaveMoment(this.repository);

  @override
  Future<Either<Failure, Moment>> call(SaveMomentParams params) async {
    return await repository.saveMoment(
      userId: params.userId,
      moodState: params.moodState,
      recommendedDrinkId: params.recommendedDrinkId,
      recommendedDrinkName: params.recommendedDrinkName,
      tasteProfile: params.tasteProfile,
      aiReflection: params.aiReflection,
    );
  }
}

class SaveMomentParams {
  final String userId;
  final dynamic moodState; // MoodState
  final String recommendedDrinkId;
  final String recommendedDrinkName;
  final List<String> tasteProfile;
  final String? aiReflection;

  SaveMomentParams({
    required this.userId,
    required this.moodState,
    required this.recommendedDrinkId,
    required this.recommendedDrinkName,
    required this.tasteProfile,
    this.aiReflection,
  });
}
