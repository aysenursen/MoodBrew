import '../../domain/entities/mood_state.dart';

class MoodStateModel {
  final String energy;
  final String mentalNeed;
  final String riskMood;

  MoodStateModel({
    required this.energy,
    required this.mentalNeed,
    required this.riskMood,
  });

  factory MoodStateModel.fromJson(Map<String, dynamic> json) {
    return MoodStateModel(
      energy: json['energy'] as String,
      mentalNeed: json['mentalNeed'] as String,
      riskMood: json['riskMood'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'energy': energy, 'mentalNeed': mentalNeed, 'riskMood': riskMood};
  }

  factory MoodStateModel.fromEntity(MoodState entity) {
    return MoodStateModel(
      energy: entity.energy.toString().split('.').last,
      mentalNeed: entity.mentalNeed.toString().split('.').last,
      riskMood: entity.riskMood.toString().split('.').last,
    );
  }

  MoodState toEntity() {
    return MoodState(
      energy: _parseEnergy(energy),
      mentalNeed: _parseMentalNeed(mentalNeed),
      riskMood: _parseRiskMood(riskMood),
    );
  }

  static EnergyLevel _parseEnergy(String value) {
    switch (value) {
      case 'low':
        return EnergyLevel.low;
      case 'okay':
        return EnergyLevel.okay;
      case 'high':
        return EnergyLevel.high;
      default:
        return EnergyLevel.okay;
    }
  }

  static MentalNeed _parseMentalNeed(String value) {
    switch (value) {
      case 'focus':
        return MentalNeed.focus;
      case 'slowDown':
        return MentalNeed.slowDown;
      case 'enjoy':
        return MentalNeed.enjoy;
      default:
        return MentalNeed.enjoy;
    }
  }

  static RiskMood _parseRiskMood(String value) {
    switch (value) {
      case 'familiar':
        return RiskMood.familiar;
      case 'slightlyDifferent':
        return RiskMood.slightlyDifferent;
      case 'surpriseMe':
        return RiskMood.surpriseMe;
      default:
        return RiskMood.familiar;
    }
  }
}
