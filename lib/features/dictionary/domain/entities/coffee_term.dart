import 'package:equatable/equatable.dart';

class CoffeeTerm extends Equatable {
  final String id;
  final String term;
  final String definition;
  final String? category;

  const CoffeeTerm({
    required this.id,
    required this.term,
    required this.definition,
    this.category,
  });

  @override
  List<Object?> get props => [id];
}
