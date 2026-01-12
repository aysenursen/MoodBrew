import 'package:equatable/equatable.dart';
import 'drink.dart';

class Recommendation extends Equatable {
  final Drink drink;
  final String emotionalDescription;
  final String funFact;
  final List<String> tasteProfile;

  const Recommendation({
    required this.drink,
    required this.emotionalDescription,
    required this.funFact,
    required this.tasteProfile,
  });

  @override
  List<Object?> get props => [drink, emotionalDescription];
}
