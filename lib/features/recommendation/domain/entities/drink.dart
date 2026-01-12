import 'package:equatable/equatable.dart';

class Drink extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> tasteProfile;
  final String imagePath;
  final String whyThisWorks;
  final int caffeineLevel; // 0-5
  final int intensityLevel; // 0-5

  const Drink({
    required this.id,
    required this.name,
    required this.description,
    required this.tasteProfile,
    required this.imagePath,
    required this.whyThisWorks,
    required this.caffeineLevel,
    required this.intensityLevel,
  });

  @override
  List<Object?> get props => [id];
}
