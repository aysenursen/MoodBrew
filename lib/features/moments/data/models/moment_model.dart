import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/moment.dart';
import '../../../check_in/domain/entities/mood_state.dart';

class MomentModel {
  final String id;
  final DateTime timestamp;
  final Map<String, dynamic> moodStateData;
  final String recommendedDrinkId;
  final String recommendedDrinkName;
  final List<String> tasteProfile;
  final String? aiReflection;

  MomentModel({
    required this.id,
    required this.timestamp,
    required this.moodStateData,
    required this.recommendedDrinkId,
    required this.recommendedDrinkName,
    required this.tasteProfile,
    this.aiReflection,
  });

  factory MomentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return MomentModel(
      id: doc.id,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      moodStateData: data['moodState'] as Map<String, dynamic>,
      recommendedDrinkId: data['recommendedDrinkId'] as String,
      recommendedDrinkName: data['recommendedDrinkName'] as String,
      tasteProfile: List<String>.from(data['tasteProfile'] as List),
      aiReflection: data['aiReflection'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'timestamp': Timestamp.fromDate(timestamp),
      'moodState': moodStateData,
      'recommendedDrinkId': recommendedDrinkId,
      'recommendedDrinkName': recommendedDrinkName,
      'tasteProfile': tasteProfile,
      'aiReflection': aiReflection,
    };
  }

  Moment toEntity() {
    // MoodState'i parse et
    final moodState = MoodState(
      energy: _parseEnergy(moodStateData['energy'] as String),
      mentalNeed: _parseMentalNeed(moodStateData['mentalNeed'] as String),
      riskMood: _parseRiskMood(moodStateData['riskMood'] as String),
    );

    return Moment(
      id: id,
      timestamp: timestamp,
      moodState: moodState,
      recommendedDrinkId: recommendedDrinkId,
      recommendedDrinkName: recommendedDrinkName,
      tasteProfile: tasteProfile,
      aiReflection: aiReflection,
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
