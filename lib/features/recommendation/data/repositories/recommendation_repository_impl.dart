import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:moodbrew/core/constants/assets.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/repositories/recommendation_repository.dart';
import '../../../check_in/domain/entities/mood_state.dart';
import '../datasources/drinks_local_data_source.dart';
import '../datasources/recommendation_engine.dart';
import '../../../reflection/data/datasources/reflection_generator.dart';

class RecommendationRepositoryImpl implements RecommendationRepository {
  final DrinksLocalDataSource drinksDataSource;
  final RecommendationEngine engine;
  final ReflectionGenerator reflectionGenerator;

  RecommendationRepositoryImpl({
    required this.drinksDataSource,
    required this.engine,
    required this.reflectionGenerator,
  });

  @override
  Future<Either<Failure, Recommendation>> getRecommendation(
    MoodState moodState,
  ) async {
    try {
      // 1. Önce içeceği seç
      final drink = engine.getRecommendation(moodState);

      // 2. Duygusal açıklama oluştur
      final emotionalDescription = reflectionGenerator
          .generateEmotionalDescription(drink, moodState);

      // 3. Tat profili oluştur
      final tasteProfile = reflectionGenerator.generateTasteProfile(
        drink,
        moodState,
      );

      // 4. Fun fact getir
      final funFact = await _getFunFact(drink.tasteProfile);

      return Right(
        Recommendation(
          drink: drink,
          emotionalDescription: emotionalDescription,
          funFact: funFact,
          tasteProfile: tasteProfile,
        ),
      );
    } on CacheException {
      return const Left(CacheFailure('Could not get recommendation'));
    }
  }

  @override
  Future<Either<Failure, String>> getFunFact(List<String> tags) async {
    try {
      final funFact = await _getFunFact(tags);
      return Right(funFact);
    } on CacheException {
      return const Left(CacheFailure('Could not get fun fact'));
    }
  }

  Future<String> _getFunFact(List<String> tags) async {
    final jsonString = await rootBundle.loadString(Assets.funFactsJson);
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    final List funFacts = jsonData['fun_facts'];

    // Tag filtreleme (şimdilik basit)
    final filteredFacts = funFacts.where((fact) {
      final List<dynamic> factTags = fact['tags'];
      return tags.any((tag) => factTags.contains(tag));
    }).toList();

    final List source = filteredFacts.isNotEmpty ? filteredFacts : funFacts;

    final index = DateTime.now().millisecondsSinceEpoch % source.length;
    return source[index]['text'];
  }
}
