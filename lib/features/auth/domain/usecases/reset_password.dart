import 'package:dartz/dartz.dart';
import 'package:moodbrew/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class ResetPassword implements UseCase<void, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPassword(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(params.email);
  }
}

class ResetPasswordParams {
  final String email;

  ResetPasswordParams({required this.email});
}
