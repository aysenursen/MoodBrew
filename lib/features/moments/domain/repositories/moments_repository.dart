import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/moment.dart';

abstract class MomentsRepository {
  Future<Either<Failure, Moment>> saveMoment({
    required String userId,
    required dynamic moodState,
    required String recommendedDrinkId,
    required String recommendedDrinkName,
    required List<String> tasteProfile,
    String? aiReflection,
  });

  Future<Either<Failure, List<Moment>>> getMoments(String userId);
  Future<Either<Failure, void>> deleteMoment(String momentId);
}
