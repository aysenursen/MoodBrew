import 'package:dartz/dartz.dart';
import 'package:moodbrew/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import 'sign_in_with_email.dart';

class SignUpWithEmail implements UseCase<User, EmailAuthParams> {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  @override
  Future<Either<Failure, User>> call(EmailAuthParams params) async {
    return await repository.signUpWithEmail(params.email, params.password);
  }
}
