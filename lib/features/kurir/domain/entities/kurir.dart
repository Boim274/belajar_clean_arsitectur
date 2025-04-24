import 'package:equatable/equatable.dart';

class Kurir extends Equatable {
  final String id;
  final String namaKurir;
  final String nomorTlp;
  final String email;
  final String layanan;
  final String? gudangId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Kurir(
      {required this.id,
      required this.namaKurir,
      required this.nomorTlp,
      required this.email,
      required this.layanan,
      this.gudangId,
      this.createdAt,
      this.updatedAt});

  @override
  List<Object?> get props =>
      [id, namaKurir, nomorTlp, email, layanan, gudangId, createdAt, updatedAt];
}
