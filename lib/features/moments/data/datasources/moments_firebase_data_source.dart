import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../models/moment_model.dart';

abstract class MomentsFirebaseDataSource {
  Future<MomentModel> saveMoment({
    required String userId,
    required dynamic moodState,
    required String recommendedDrinkId,
    required String recommendedDrinkName,
    required List<String> tasteProfile,
    String? aiReflection,
  });

  Future<List<MomentModel>> getMoments(String userId);
  Future<void> deleteMoment(String momentId);
}

class MomentsFirebaseDataSourceImpl implements MomentsFirebaseDataSource {
  final FirebaseFirestore firestore;

  MomentsFirebaseDataSourceImpl({required this.firestore});

  @override
  Future<MomentModel> saveMoment({
    required String userId,
    required dynamic moodState,
    required String recommendedDrinkId,
    required String recommendedDrinkName,
    required List<String> tasteProfile,
    String? aiReflection,
  }) async {
    try {
      final docRef = firestore.collection('moments').doc();

      final momentData = {
        'id': docRef.id,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
        'moodState': {
          'energy': moodState.energy.toString().split('.').last,
          'mentalNeed': moodState.mentalNeed.toString().split('.').last,
          'riskMood': moodState.riskMood.toString().split('.').last,
        },
        'recommendedDrinkId': recommendedDrinkId,
        'recommendedDrinkName': recommendedDrinkName,
        'tasteProfile': tasteProfile,
        'aiReflection': aiReflection,
      };

      await docRef.set(momentData);

      // Kaydedilen veriyi geri oku
      final doc = await docRef.get();
      return MomentModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException('Failed to save moment: ${e.toString()}');
    }
  }

  @override
  Future<List<MomentModel>> getMoments(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection('moments')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => MomentModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw ServerException('Failed to get moments: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteMoment(String momentId) async {
    try {
      await firestore.collection('moments').doc(momentId).delete();
    } catch (e) {
      throw ServerException('Failed to delete moment: ${e.toString()}');
    }
  }
}
