import 'package:equatable/equatable.dart';

enum EnergyLevel { low, okay, high }

enum MentalNeed { focus, slowDown, enjoy }

enum RiskMood { familiar, slightlyDifferent, surpriseMe }

class MoodState extends Equatable {
  final EnergyLevel energy;
  final MentalNeed mentalNeed;
  final RiskMood riskMood;

  const MoodState({
    required this.energy,
    required this.mentalNeed,
    required this.riskMood,
  });

  @override
  List<Object?> get props => [energy, mentalNeed, riskMood];

  MoodState copyWith({
    EnergyLevel? energy,
    MentalNeed? mentalNeed,
    RiskMood? riskMood,
  }) {
    return MoodState(
      energy: energy ?? this.energy,
      mentalNeed: mentalNeed ?? this.mentalNeed,
      riskMood: riskMood ?? this.riskMood,
    );
  }
}
