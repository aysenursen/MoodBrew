import 'package:equatable/equatable.dart';

class Reflection extends Equatable {
  final String text; // "You're a bit low on energy..."
  final List<String> tasteProfile; // ["Soft", "Warm", "Chocolate & nutty"]

  const Reflection({required this.text, required this.tasteProfile});

  @override
  List<Object?> get props => [text, tasteProfile];
}
