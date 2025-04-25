import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/users.dart';
import '../repositories/users_repositories.dart';

class SignInWithEmail implements UseCase<UserEntity, SignInWithEmailParams> {
  final AuthRepository repository;

  SignInWithEmail({required this.repository});

  @override
  Future<Either<Exception, UserEntity>> call(
      SignInWithEmailParams params) async {
    return await repository.signInWithEmailAndPassword(
      params.email,
      params.password,
    );
  }
}

class SignInWithEmailParams {
  final String email;
  final String password;

  SignInWithEmailParams({required this.email, required this.password});
}

