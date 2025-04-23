import 'package:equatable/equatable.dart';

class Gudang extends Equatable {
  final String id;
  final String namaGudang;
  final String alamat;
  final String nomorTlp;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Gudang(
      {required this.id,
      required this.namaGudang,
      required this.alamat,
      required this.nomorTlp,
      this.createdAt,
      this.updatedAt});

  @override
  List<Object?> get props => [id, namaGudang, alamat, nomorTlp, createdAt, updatedAt];
}
