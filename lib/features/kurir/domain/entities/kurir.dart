import 'package:equatable/equatable.dart';

class Kurir extends Equatable {
  final String id;
  final String namaKurir;
  final String nomorTlp;
  final String email;
  final String kendaraan; // Motor, Mobil, Sepeda, dll
  final String status; // Aktif, Tidak Aktif, dll
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Kurir(
      {required this.id,
      required this.namaKurir,
      required this.nomorTlp,
      required this.email,
      required this.kendaraan,
      required this.status,
      this.createdAt,
      this.updatedAt});

  @override
  List<Object?> get props => [
        id,
        namaKurir,
        nomorTlp,
        email,
        kendaraan,
        status,
        createdAt,
        updatedAt
      ];
}
