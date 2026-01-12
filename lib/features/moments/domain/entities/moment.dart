import 'package:equatable/equatable.dart';
import '../../../check_in/domain/entities/mood_state.dart' show MoodState;

class Moment extends Equatable {
  final String id;
  final DateTime timestamp;
  final MoodState moodState;
  final String recommendedDrinkId;
  final String recommendedDrinkName;
  final List<String> tasteProfile;
  final String? aiReflection; // Premium only

  const Moment({
    required this.id,
    required this.timestamp,
    required this.moodState,
    required this.recommendedDrinkId,
    required this.recommendedDrinkName,
    required this.tasteProfile,
    this.aiReflection,
  });

  @override
  List<Object?> get props => [id, timestamp];
}
