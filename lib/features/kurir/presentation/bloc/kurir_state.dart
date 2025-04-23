part of 'kurir_bloc.dart';

abstract class KurirState extends Equatable {}

class KurirInitial extends KurirState {
  @override
  List<Object?> get props => [];
}

class KurirStateLoading extends KurirState {
  @override
  List<Object?> get props => [];
}

class KurirStateError extends KurirState {
  final String message;

  KurirStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class KurirStateLoadedAll extends KurirState {
  final List<Kurir> kurirs;

  KurirStateLoadedAll({required this.kurirs});

  @override
  List<Object?> get props => [kurirs];
}

class KurirStateLoaded extends KurirState {
  final Kurir kurir;

  KurirStateLoaded({required this.kurir});

  @override
  List<Object?> get props => [kurir];
}

class KurirStateSuccess extends KurirState {
  @override
  List<Object?> get props => [];
}
