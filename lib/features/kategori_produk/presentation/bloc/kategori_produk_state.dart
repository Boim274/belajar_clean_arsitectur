part of 'kategori_produk_bloc.dart';

abstract class KategoriProdukState extends Equatable {}

class KategoriProdukInitial extends KategoriProdukState {
  @override
  List<Object?> get props => [];
}

class KategoriProdukStateLoading extends KategoriProdukState {
  @override
  List<Object?> get props => [];
}

class KategoriProdukStateError extends KategoriProdukState {
  final String message;

  KategoriProdukStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class KategoriProdukStateLoadedAll extends KategoriProdukState {
  final List<KategoriProduk> kategoriProduks;

  KategoriProdukStateLoadedAll({required this.kategoriProduks});
  @override
  List<Object?> get props => [kategoriProduks];
}

class KategoriProdukStateLoaded extends KategoriProdukState {
  final KategoriProduk kategoriProduk;

  KategoriProdukStateLoaded({required this.kategoriProduk});
  @override
  List<Object?> get props => [kategoriProduk];
}

class KategoriProdukStateSuccess extends KategoriProdukState {
  @override
  List<Object?> get props => [];
}
