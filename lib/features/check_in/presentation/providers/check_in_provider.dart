import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/mood_state.dart';

class CheckInState {
  final EnergyLevel? energy;
  final MentalNeed? mentalNeed;
  final RiskMood? riskMood;
  final int currentStep;

  CheckInState({
    this.energy,
    this.mentalNeed,
    this.riskMood,
    this.currentStep = 0,
  });

  CheckInState copyWith({
    EnergyLevel? energy,
    MentalNeed? mentalNeed,
    RiskMood? riskMood,
    int? currentStep,
  }) {
    return CheckInState(
      energy: energy ?? this.energy,
      mentalNeed: mentalNeed ?? this.mentalNeed,
      riskMood: riskMood ?? this.riskMood,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  bool get isComplete =>
      energy != null && mentalNeed != null && riskMood != null;

  MoodState? toMoodState() {
    if (!isComplete) return null;
    return MoodState(
      energy: energy!,
      mentalNeed: mentalNeed!,
      riskMood: riskMood!,
    );
  }
}

class CheckInNotifier extends StateNotifier<CheckInState> {
  CheckInNotifier() : super(CheckInState());

  void setEnergy(EnergyLevel energy) {
    state = state.copyWith(energy: energy, currentStep: 1);
  }

  void setMentalNeed(MentalNeed need) {
    state = state.copyWith(mentalNeed: need, currentStep: 2);
  }

  void setRiskMood(RiskMood mood) {
    state = state.copyWith(riskMood: mood, currentStep: 3);
  }

  void reset() {
    state = CheckInState();
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }
}

final checkInProvider = StateNotifierProvider<CheckInNotifier, CheckInState>((
  ref,
) {
  return CheckInNotifier();
});
