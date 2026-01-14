import 'package:dartz/dartz.dart';
import 'package:moodbrew/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/reflection.dart';
import '../repositories/reflection_repository.dart';
import '../../../check_in/domain/entities/mood_state.dart';

class GenerateReflection implements UseCase<Reflection, MoodState> {
  final ReflectionRepository repository;

  GenerateReflection(this.repository);

  @override
  Future<Either<Failure, Reflection>> call(MoodState moodState) async {
    return await repository.generateReflection(moodState);
  }
}
