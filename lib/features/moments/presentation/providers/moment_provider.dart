import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/moment.dart';
import '../../domain/usecases/get_moments.dart';
import '../../domain/usecases/save_moment.dart';
import '../../../../injection_container.dart';

final momentsProvider = FutureProvider.family<List<Moment>, String>((
  ref,
  userId,
) async {
  final getMoments = sl<GetMoments>();
  final result = await getMoments(userId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (moments) => moments,
  );
});

class MomentsNotifier extends StateNotifier<AsyncValue<List<Moment>>> {
  final GetMoments _getMoments;
  final SaveMoment _saveMoment;

  MomentsNotifier(this._getMoments, this._saveMoment)
    : super(const AsyncValue.loading());

  Future<void> loadMoments(String userId) async {
    state = const AsyncValue.loading();

    final result = await _getMoments(userId);

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (moments) => AsyncValue.data(moments),
    );
  }

  Future<bool> saveMoment(SaveMomentParams params) async {
    final result = await _saveMoment(params);

    return result.fold((failure) => false, (moment) {
      // Yeni moment'i listeye ekle
      state.whenData((moments) {
        state = AsyncValue.data([moment, ...moments]);
      });
      return true;
    });
  }
}

final momentsNotifierProvider =
    StateNotifierProvider<MomentsNotifier, AsyncValue<List<Moment>>>((ref) {
      return MomentsNotifier(sl<GetMoments>(), sl<SaveMoment>());
    });
