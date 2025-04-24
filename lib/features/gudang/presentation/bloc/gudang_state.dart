part of 'gudang_bloc.dart';

abstract class GudangState extends Equatable {}

class GudangInitial extends GudangState {
  @override
  List<Object?> get props => [];
}

class GudangStateLoading extends GudangState {
  @override
  List<Object?> get props => [];
}

class GudangStateError extends GudangState {
  final String message;

  GudangStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class GudangStateLoadedAll extends GudangState {
  final List<Gudang> gudangs;

  GudangStateLoadedAll({required this.gudangs});

  @override
  List<Object?> get props => [gudangs];
}

class GudangStateLoaded extends GudangState {
  final Gudang gudang;

  GudangStateLoaded({required this.gudang});

  @override
  List<Object?> get props => [gudang];
}

class GudangStateSuccess extends GudangState {
  @override
  List<Object?> get props => [];
}
