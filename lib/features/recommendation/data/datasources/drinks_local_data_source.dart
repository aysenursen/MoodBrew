import '../../domain/entities/drink.dart';

abstract class DrinksLocalDataSource {
  List<Drink> getDrinks();
}

class DrinksLocalDataSourceImpl implements DrinksLocalDataSource {
  @override
  List<Drink> getDrinks() {
    // Gerçek uygulamada JSON'dan yüklenecek
    return [
      const Drink(
        id: 'espresso',
        name: 'Espresso',
        description: 'Bold and intense',
        tasteProfile: ['Strong', 'Clean', 'Bold'],
        imagePath: 'assets/images/drinks/espresso.png',
        whyThisWorks: 'Pure and focused, just like you need right now.',
        caffeineLevel: 5,
        intensityLevel: 5,
      ),
      const Drink(
        id: 'cappuccino',
        name: 'Cappuccino',
        description: 'Balanced and smooth',
        tasteProfile: ['Creamy', 'Smooth', 'Balanced'],
        imagePath: 'assets/images/drinks/cappuccino.png',
        whyThisWorks: 'Comforting layers that match your mood.',
        caffeineLevel: 3,
        intensityLevel: 3,
      ),
      const Drink(
        id: 'latte',
        name: 'Latte',
        description: 'Gentle and comforting',
        tasteProfile: ['Soft', 'Warm', 'Milky'],
        imagePath: 'assets/images/drinks/latte.png',
        whyThisWorks: 'Gentle energy wrapped in comfort.',
        caffeineLevel: 2,
        intensityLevel: 2,
      ),
      // Daha fazla içecek eklenecek...
    ];
  }
}
