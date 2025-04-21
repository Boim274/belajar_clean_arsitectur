part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthStateInitial extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthStateLoading extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthStateLoaded extends AuthState {
  final UserEntity usermodel;

  AuthStateLoaded(this.usermodel);

  @override
  // TODO: implement props
  List<Object?> get props => [usermodel];
}

class AuthStateError extends AuthState {
  final String message;

  AuthStateError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
