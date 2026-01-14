import 'package:dartz/dartz.dart';
import 'package:moodbrew/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/reflection_repository.dart';
import '../../../check_in/domain/entities/mood_state.dart';

class GenerateTasteProfile implements UseCase<List<String>, MoodState> {
  final ReflectionRepository repository;

  GenerateTasteProfile(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(MoodState moodState) async {
    // Sync operation, wrap in Future
    return Future.value(repository.generateTasteProfile(moodState));
  }
}
