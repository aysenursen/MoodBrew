import 'package:equatable/equatable.dart';
import 'package:moodbrew/features/check_in/domain/entities/mood_state.dart';

class AiMoodParse extends Equatable {
  final MoodState moodState;
  final String interpretation;

  const AiMoodParse({required this.moodState, required this.interpretation});

  @override
  List<Object?> get props => [moodState, interpretation];
}

class AiReflection extends Equatable {
  final String reflection;
  final String personalizedWhy;

  const AiReflection({required this.reflection, required this.personalizedWhy});

  @override
  List<Object?> get props => [reflection, personalizedWhy];
}
