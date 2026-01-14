import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/reflection.dart';

part 'reflection_model.g.dart';

@JsonSerializable()
class ReflectionModel {
  final String text;
  final List<String> tasteProfile;

  ReflectionModel({required this.text, required this.tasteProfile});

  factory ReflectionModel.fromJson(Map<String, dynamic> json) =>
      _$ReflectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReflectionModelToJson(this);

  Reflection toEntity() {
    return Reflection(text: text, tasteProfile: tasteProfile);
  }

  factory ReflectionModel.fromEntity(Reflection entity) {
    return ReflectionModel(
      text: entity.text,
      tasteProfile: entity.tasteProfile,
    );
  }
}
