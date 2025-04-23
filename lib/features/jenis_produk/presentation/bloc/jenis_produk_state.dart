part of 'jenis_produk_bloc.dart';

abstract class JenisProdukState extends Equatable {}

class JenisProdukInitial extends JenisProdukState {
  @override
  List<Object?> get props => [];
}

class JenisProdukStateLoading extends JenisProdukState {
  @override
  List<Object?> get props => [];
}

class JenisProdukStateError extends JenisProdukState {
  final String message;

  JenisProdukStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class JenisProdukStateLoadedAll extends JenisProdukState {
  final List<Jenis> jenis;

  JenisProdukStateLoadedAll({required this.jenis});
  @override
  List<Object?> get props => [jenis];
}

class JenisProdukStateLoaded extends JenisProdukState {
  final Jenis jenis;

  JenisProdukStateLoaded({required this.jenis});
  @override
  List<Object?> get props => [jenis];
}

class JenisProdukStateSuccess extends JenisProdukState {
  @override
  List<Object?> get props => [];
}
