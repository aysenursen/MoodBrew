class Assets {
  // Images
  static const String imagesPath = 'assets/images/';
  static const String drinksPath = '${imagesPath}drinks/';
  static const String illustrationsPath = 'assets/illustrations/';

  // Data
  static const String dataPath = 'assets/data/';
  static const String drinksJson = '${dataPath}drinks.json';
  static const String dictionaryJson = '${dataPath}dictionary.json';
  static const String funFactsJson = '${dataPath}fun_facts.json';

  // Drink images
  static String drinkImage(String drinkId) => '$drinksPath$drinkId.png';

  // Illustrations
  static const String splashIllustration = '${illustrationsPath}splash.svg';
  static const String lowEnergyIllustration =
      '${illustrationsPath}low_energy.svg';
}
