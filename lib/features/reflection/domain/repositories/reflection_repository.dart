import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/reflection.dart';
import '../../../check_in/domain/entities/mood_state.dart';

abstract class ReflectionRepository {
  Future<Either<Failure, Reflection>> generateReflection(MoodState moodState);
  Either<Failure, List<String>> generateTasteProfile(MoodState moodState);
}
