import 'package:dartz/dartz.dart';
import 'package:moodbrew/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail implements UseCase<User, EmailAuthParams> {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  @override
  Future<Either<Failure, User>> call(EmailAuthParams params) async {
    return await repository.signInWithEmail(params.email, params.password);
  }
}

class EmailAuthParams {
  final String email;
  final String password;

  EmailAuthParams({required this.email, required this.password});
}
