// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrinkModel _$DrinkModelFromJson(Map<String, dynamic> json) => DrinkModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  tasteProfile: (json['tasteProfile'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  imagePath: json['imagePath'] as String,
  whyThisWorks: json['whyThisWorks'] as String,
  caffeineLevel: (json['caffeineLevel'] as num).toInt(),
  intensityLevel: (json['intensityLevel'] as num).toInt(),
);

Map<String, dynamic> _$DrinkModelToJson(DrinkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'tasteProfile': instance.tasteProfile,
      'imagePath': instance.imagePath,
      'whyThisWorks': instance.whyThisWorks,
      'caffeineLevel': instance.caffeineLevel,
      'intensityLevel': instance.intensityLevel,
    };
