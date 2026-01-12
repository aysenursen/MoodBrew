import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart' as domain;
import '../../domain/usecases/sign_in_with_google.dart';
import '../../../../injection_container.dart';

// Auth state provider
final authStateProvider = StreamProvider<domain.User?>((ref) {
  // Firebase Auth state stream'ini dinle
  // Şimdilik basit bir implementasyon
  return Stream.value(null);
});

// Auth controller
class AuthController extends StateNotifier<AsyncValue<domain.User?>> {
  final SignInWithGoogle _signInWithGoogle;

  AuthController(this._signInWithGoogle) : super(const AsyncValue.data(null));

  Future<Either<Failure, domain.User>> signInWithGoogle() async {
    state = const AsyncValue.loading();

    final result = await _signInWithGoogle(NoParams());

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (user) {
        state = AsyncValue.data(user);
      },
    );

    return result;
  }

  Future<void> signOut() async {
    state = const AsyncValue.data(null);
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<domain.User?>>((ref) {
      return AuthController(sl<SignInWithGoogle>());
    });
