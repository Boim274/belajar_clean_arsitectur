part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
 
}

class authEventLogin extends AuthEvent {
  final String email;
  final String password;

  authEventLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}