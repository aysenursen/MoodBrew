import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:moodbrew/features/auth/domain/repositories/auth_repository.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart' as domain;
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../../domain/usecases/reset_password.dart';
import '../../../../injection_container.dart';

// Auth state provider
final authStateProvider = StreamProvider<domain.User?>((ref) {
  return sl<AuthRepository>().authStateChanges;
});

// Auth controller
class AuthController extends StateNotifier<AsyncValue<domain.User?>> {
  final SignInWithGoogle _signInWithGoogle;
  final SignInWithEmail _signInWithEmail;
  final SignUpWithEmail _signUpWithEmail;
  final ResetPassword _resetPassword;

  AuthController(
    this._signInWithGoogle,
    this._signInWithEmail,
    this._signUpWithEmail,
    this._resetPassword,
  ) : super(const AsyncValue.data(null));

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

  Future<Either<Failure, domain.User>> signInWithEmail(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();

    final result = await _signInWithEmail(
      EmailAuthParams(email: email, password: password),
    );

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

  Future<Either<Failure, domain.User>> signUpWithEmail(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();

    final result = await _signUpWithEmail(
      EmailAuthParams(email: email, password: password),
    );

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

  Future<Either<Failure, void>> resetPassword(String email) async {
    return await _resetPassword(ResetPasswordParams(email: email));
  }

  Future<void> signOut() async {
    state = const AsyncValue.data(null);
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<domain.User?>>((ref) {
      return AuthController(
        sl<SignInWithGoogle>(),
        sl<SignInWithEmail>(),
        sl<SignUpWithEmail>(),
        sl<ResetPassword>(),
      );
    });
