import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/reflection.dart';
import '../../domain/repositories/reflection_repository.dart';
import '../../../check_in/domain/entities/mood_state.dart';
import '../datasources/reflection_generator.dart';

class ReflectionRepositoryImpl implements ReflectionRepository {
  final ReflectionGenerator generator;

  ReflectionRepositoryImpl({required this.generator});

  @override
  Future<Either<Failure, Reflection>> generateReflection(
    MoodState moodState,
  ) async {
    try {
      final text = generator.generateReflectionText(moodState);
      final tasteProfile = generator.generateTasteProfileFromMood(moodState);

      final reflection = Reflection(text: text, tasteProfile: tasteProfile);

      return Right(reflection);
    } catch (e) {
      return Left(ServerFailure('Failed to generate reflection'));
    }
  }

  @override
  Either<Failure, List<String>> generateTasteProfile(MoodState moodState) {
    try {
      final tasteProfile = generator.generateTasteProfileFromMood(moodState);
      return Right(tasteProfile);
    } catch (e) {
      return Left(ServerFailure('Failed to generate taste profile'));
    }
  }
}
