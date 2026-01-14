import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/mood_state.dart';

abstract class CheckInRepository {
  Future<Either<Failure, MoodState>> submitCheckIn(MoodState moodState);
  Either<Failure, MoodState> getLastCheckIn();
  Future<Either<Failure, void>> clearCheckIn();
}
