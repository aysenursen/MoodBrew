import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/mood_state.dart';
import '../../domain/repositories/check_in_repository.dart';
import '../datasources/check_in_local_data_source.dart';
import '../models/mood_state_model.dart';

class CheckInRepositoryImpl implements CheckInRepository {
  final CheckInLocalDataSource localDataSource;

  CheckInRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, MoodState>> submitCheckIn(MoodState moodState) async {
    try {
      final model = MoodStateModel.fromEntity(moodState);
      await localDataSource.cacheCheckIn(model);
      return Right(moodState);
    } on CacheException {
      return const Left(CacheFailure('Failed to save check-in'));
    }
  }

  @override
  Either<Failure, MoodState> getLastCheckIn() {
    try {
      final model = localDataSource.getLastCheckIn();
      if (model == null) {
        return const Left(CacheFailure('No previous check-in found'));
      }
      return Right(model.toEntity());
    } on CacheException {
      return const Left(CacheFailure('Failed to get last check-in'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCheckIn() async {
    try {
      await localDataSource.clearCheckIn();
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure('Failed to clear check-in'));
    }
  }
}
