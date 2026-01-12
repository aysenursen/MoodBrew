/*import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_firebase_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final userModel = await dataSource.signInWithGoogle();
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithApple() async {
    try {
      final userModel = await dataSource.signInWithApple();
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final userModel = await dataSource.signInWithEmail(email, password);
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await dataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('An unexpected error occurred'));
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return dataSource.authStateChanges.map(
      (userModel) => userModel?.toEntity(),
    );
  }
}
*/
