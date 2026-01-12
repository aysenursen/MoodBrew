import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart' show UseCase;
import '../entities/moment.dart';
import '../repositories/moments_repository.dart';

class GetMoments implements UseCase<List<Moment>, String> {
  final MomentsRepository repository;

  GetMoments(this.repository);

  @override
  Future<Either<Failure, List<Moment>>> call(String userId) async {
    return await repository.getMoments(userId);
  }
}
