part of 'suplier_bloc.dart';

abstract class SuplierState extends Equatable {}

class SuplierInitial extends SuplierState {
  @override
  List<Object?> get props => [];
}

class SuplierStateLoading extends SuplierState {
  @override
  List<Object?> get props => [];
}

class SuplierStateError extends SuplierState {
  final String message;

  SuplierStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class SuplierStateLoadedAll extends SuplierState {
  final List<Suplier> supliers;

  SuplierStateLoadedAll({required this.supliers});

  @override
  List<Object?> get props => [supliers];
}

class SuplierStateLoaded extends SuplierState {
  final Suplier suplier;

  SuplierStateLoaded({required this.suplier});

  @override
  List<Object?> get props => [suplier];
}

class SuplierStateSuccess extends SuplierState {
  @override
  List<Object?> get props => [];
}
