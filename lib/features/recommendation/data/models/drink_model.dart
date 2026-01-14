import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/drink.dart';

part 'drink_model.g.dart';

@JsonSerializable()
class DrinkModel {
  final String id;
  final String name;
  final String description;
  final List<String> tasteProfile;
  final String imagePath;
  final String whyThisWorks;
  final int caffeineLevel;
  final int intensityLevel;

  DrinkModel({
    required this.id,
    required this.name,
    required this.description,
    required this.tasteProfile,
    required this.imagePath,
    required this.whyThisWorks,
    required this.caffeineLevel,
    required this.intensityLevel,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> json) =>
      _$DrinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkModelToJson(this);

  Drink toEntity() {
    return Drink(
      id: id,
      name: name,
      description: description,
      tasteProfile: tasteProfile,
      imagePath: imagePath,
      whyThisWorks: whyThisWorks,
      caffeineLevel: caffeineLevel,
      intensityLevel: intensityLevel,
    );
  }

  factory DrinkModel.fromEntity(Drink entity) {
    return DrinkModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      tasteProfile: entity.tasteProfile,
      imagePath: entity.imagePath,
      whyThisWorks: entity.whyThisWorks,
      caffeineLevel: entity.caffeineLevel,
      intensityLevel: entity.intensityLevel,
    );
  }
}
