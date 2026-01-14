import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/moment.dart';
import '../../domain/repositories/moments_repository.dart';
import '../datasources/moments_firebase_data_source.dart';

class MomentsRepositoryImpl implements MomentsRepository {
  final MomentsFirebaseDataSource dataSource;

  MomentsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Moment>> saveMoment({
    required String userId,
    required dynamic moodState,
    required String recommendedDrinkId,
    required String recommendedDrinkName,
    required List<String> tasteProfile,
    String? aiReflection,
  }) async {
    try {
      final momentModel = await dataSource.saveMoment(
        userId: userId,
        moodState: moodState,
        recommendedDrinkId: recommendedDrinkId,
        recommendedDrinkName: recommendedDrinkName,
        tasteProfile: tasteProfile,
        aiReflection: aiReflection,
      );

      return Right(momentModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to save moment'));
    }
  }

  @override
  Future<Either<Failure, List<Moment>>> getMoments(String userId) async {
    try {
      final momentModels = await dataSource.getMoments(userId);
      final moments = momentModels.map((model) => model.toEntity()).toList();
      return Right(moments);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to get moments'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMoment(String momentId) async {
    try {
      await dataSource.deleteMoment(momentId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to delete moment'));
    }
  }
}
