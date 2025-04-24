import 'package:equatable/equatable.dart';

class Produk extends Equatable {
  final String id;
  final String namaProduk;
  final String harga;
  final String deskripsi;
  final String? kategoriId;
  final String? jenisId;
  final String? gudangId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Produk({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.deskripsi,
    this.kategoriId,
    this.jenisId,
    this.gudangId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        namaProduk,
        harga,
        deskripsi,
        createdAt,
        updatedAt,
        kategoriId,
        jenisId,
        gudangId
      ];
}
