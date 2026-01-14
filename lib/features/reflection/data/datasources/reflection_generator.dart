import '../../../check_in/domain/entities/mood_state.dart';
import '../../../recommendation/domain/entities/drink.dart';

class ReflectionGenerator {
  String generateReflectionText(MoodState mood) {
    final energyText = _getEnergyText(mood.energy);
    final needText = _getNeedText(mood.mentalNeed);

    return 'You\'re $energyText and looking for $needText.';
  }

  String generateEmotionalDescription(Drink drink, MoodState mood) {
    // Mood'a ve içeceğe göre duygusal açıklama
    if (mood.energy == EnergyLevel.low &&
        mood.mentalNeed == MentalNeed.slowDown) {
      return 'A gentle companion for your quiet moment.';
    }

    if (mood.energy == EnergyLevel.high &&
        mood.mentalNeed == MentalNeed.enjoy) {
      return 'Bright and lively, just like your energy.';
    }

    if (mood.mentalNeed == MentalNeed.focus) {
      return 'Clean and focused, to match your mindset.';
    }

    return 'A balanced choice for right now.';
  }

  List<String> generateTasteProfile(Drink drink, MoodState mood) {
    // Mood'a göre tat profilini uyarla
    final profile = <String>[];

    // Temel profili ekle
    profile.addAll(drink.tasteProfile.take(3));

    // Mood'a göre ekstralar
    if (mood.mentalNeed == MentalNeed.slowDown) {
      if (!profile.contains('Soft')) profile.insert(0, 'Soft');
      if (!profile.contains('Warm')) profile.add('Warm');
    }

    return profile;
  }

  //ben ekledim
  List<String> generateTasteProfileFromMood(MoodState mood) {
    return [
      if (mood.mentalNeed == MentalNeed.slowDown) 'Soft',
      if (mood.mentalNeed == MentalNeed.focus) 'Clean',
      if (mood.mentalNeed == MentalNeed.enjoy) 'Bright',
    ];
  }

  String _getEnergyText(EnergyLevel energy) {
    switch (energy) {
      case EnergyLevel.low:
        return 'feeling a bit low on energy';
      case EnergyLevel.okay:
        return 'in a balanced state';
      case EnergyLevel.high:
        return 'energized';
    }
  }

  String _getNeedText(MentalNeed need) {
    switch (need) {
      case MentalNeed.focus:
        return 'mental clarity';
      case MentalNeed.slowDown:
        return 'comfort';
      case MentalNeed.enjoy:
        return 'something special';
    }
  }
}
