part of 'produk_bloc.dart';

abstract class ProdukEvent extends Equatable {}

class ProdukEventAdd extends ProdukEvent {
  final ProdukModel produkModel;

  ProdukEventAdd({required this.produkModel});

  @override
  List<Object?> get props => [produkModel];
}

class ProdukEventEdit extends ProdukEvent {
  final ProdukModel produkModel;

  ProdukEventEdit({required this.produkModel});

  @override
  List<Object?> get props => [produkModel];
}

class ProdukEventDelete extends ProdukEvent {
  final String id;

  ProdukEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}
