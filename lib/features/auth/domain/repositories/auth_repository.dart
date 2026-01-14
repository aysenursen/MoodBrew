import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, User>> signInWithApple();
  Future<Either<Failure, User>> signInWithEmail(String email, String password);
  Future<Either<Failure, User>> signUpWithEmail(String email, String password);
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, void>> signOut();
  Stream<User?> get authStateChanges;
}
