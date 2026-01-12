import 'package:dartz/dartz.dart';
import 'package:moodbrew/core/usecases/usecase.dart' show UseCase;
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogle implements UseCase<User, NoParams> {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}

class NoParams {}
