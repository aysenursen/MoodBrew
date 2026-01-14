// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reflection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReflectionModel _$ReflectionModelFromJson(Map<String, dynamic> json) =>
    ReflectionModel(
      text: json['text'] as String,
      tasteProfile: (json['tasteProfile'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReflectionModelToJson(ReflectionModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'tasteProfile': instance.tasteProfile,
    };
