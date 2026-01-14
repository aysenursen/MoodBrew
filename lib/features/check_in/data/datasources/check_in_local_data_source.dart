import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/mood_state_model.dart';

abstract class CheckInLocalDataSource {
  Future<void> cacheCheckIn(MoodStateModel moodState);
  MoodStateModel? getLastCheckIn();
  Future<void> clearCheckIn();
}

class CheckInLocalDataSourceImpl implements CheckInLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cachedCheckInKey = 'CACHED_CHECK_IN';

  CheckInLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCheckIn(MoodStateModel moodState) async {
    try {
      final jsonString = jsonEncode(moodState.toJson());
      await sharedPreferences.setString(cachedCheckInKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache check-in');
    }
  }

  @override
  MoodStateModel? getLastCheckIn() {
    try {
      final jsonString = sharedPreferences.getString(cachedCheckInKey);
      if (jsonString == null) return null;

      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return MoodStateModel.fromJson(jsonMap);
    } catch (e) {
      throw CacheException('Failed to get last check-in');
    }
  }

  @override
  Future<void> clearCheckIn() async {
    try {
      await sharedPreferences.remove(cachedCheckInKey);
    } catch (e) {
      throw CacheException('Failed to clear check-in');
    }
  }
}
