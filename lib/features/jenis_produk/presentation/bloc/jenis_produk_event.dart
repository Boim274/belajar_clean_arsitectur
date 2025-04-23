part of 'jenis_produk_bloc.dart';

abstract class JenisProdukEvent extends Equatable {}

class JenisEventAdd extends JenisProdukEvent {
  final JenisModel jenisModel;

  JenisEventAdd({required this.jenisModel});
  @override
  List<Object?> get props => [jenisModel];
}

class JenisEventEdit extends JenisProdukEvent {
  final JenisModel jenisModel;

  JenisEventEdit({required this.jenisModel});
  @override
  List<Object?> get props => [jenisModel];
}

class JenisEventDelete extends JenisProdukEvent {
  final String id;

  JenisEventDelete({required this.id});
  @override
  List<Object?> get props => [id];
}

class JenisEventGetAll extends JenisProdukEvent {
  @override
  List<Object?> get props => [];
}

class JenisEventGetById extends JenisProdukEvent {
  final String id;

  JenisEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}
