import '../../domain/entities/drink.dart';
import '../../../check_in/domain/entities/mood_state.dart';

class RecommendationEngine {
  final List<Drink> _drinks;

  RecommendationEngine(this._drinks);

  Drink getRecommendation(MoodState mood) {
    // Score her kahve için hesapla
    final scores = <Drink, double>{};

    for (final drink in _drinks) {
      double score = 0.0;

      // Energy bazlı skorlama
      score += _scoreEnergy(mood.energy, drink);

      // Mental need bazlı skorlama
      score += _scoreMentalNeed(mood.mentalNeed, drink);

      // Risk mood bazlı skorlama
      score += _scoreRiskMood(mood.riskMood, drink);

      scores[drink] = score;
    }

    // En yüksek skoru döndür
    return scores.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  double _scoreEnergy(EnergyLevel energy, Drink drink) {
    switch (energy) {
      case EnergyLevel.low:
        // Düşük enerji: Orta-yüksek kafein, konfor
        return (drink.caffeineLevel / 5.0) * 30 +
            (drink.intensityLevel < 3 ? 10 : 0);

      case EnergyLevel.okay:
        // Normal enerji: Dengeli, orta seviye her şey
        final balanceScore = 1.0 - ((drink.caffeineLevel - 3).abs() / 5.0);
        return balanceScore * 30;

      case EnergyLevel.high:
        // Yüksek enerji: Düşük kafein, ferahlatıcı
        return ((5 - drink.caffeineLevel) / 5.0) * 30;
    }
  }

  double _scoreMentalNeed(MentalNeed need, Drink drink) {
    switch (need) {
      case MentalNeed.focus:
        // Odaklanma: Yüksek kafein, net profil
        return (drink.caffeineLevel / 5.0) * 40 +
            (drink.tasteProfile.contains('clean') ? 15 : 0);

      case MentalNeed.slowDown:
        // Yavaşlama: Düşük kafein, yumuşak
        return ((5 - drink.caffeineLevel) / 5.0) * 40 +
            (drink.tasteProfile.any(
                  (t) => t.contains('soft') || t.contains('smooth'),
                )
                ? 15
                : 0);

      case MentalNeed.enjoy:
        // Keyif: Zengin tat, orta yoğunluk
        return (drink.intensityLevel / 5.0) * 40 +
            (drink.tasteProfile.length > 2 ? 10 : 0);
    }
  }

  double _scoreRiskMood(RiskMood risk, Drink drink) {
    switch (risk) {
      case RiskMood.familiar:
        // Tanıdık: Klasik içecekler (espresso, cappuccino, latte)
        final classicDrinks = ['espresso', 'cappuccino', 'latte', 'americano'];
        return classicDrinks.contains(drink.id) ? 30 : 0;

      case RiskMood.slightlyDifferent:
        // Biraz farklı: Varyasyonlar, özel tarifler
        return drink.tasteProfile.length > 2 ? 30 : 15;

      case RiskMood.surpriseMe:
        // Sürpriz: Özel, egzotik içecekler
        final uniqueDrinks = ['affogato', 'cortado', 'macchiato'];
        return uniqueDrinks.contains(drink.id) ? 30 : 10;
    }
  }
}
