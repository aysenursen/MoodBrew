import 'package:dartz/dartz.dart';
import 'package:moodbrew/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/mood_state.dart';
import '../repositories/check_in_repository.dart';

class SubmitCheckIn implements UseCase<MoodState, MoodState> {
  final CheckInRepository repository;

  SubmitCheckIn(this.repository);

  @override
  Future<Either<Failure, MoodState>> call(MoodState moodState) async {
    return await repository.submitCheckIn(moodState);
  }
}
