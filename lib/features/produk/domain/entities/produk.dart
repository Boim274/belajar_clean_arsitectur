import 'package:equatable/equatable.dart';

class Produk extends Equatable {
  final String id;
  final String namaProduk;
  final String harga;
  final String deskripsi;

  const Produk(
      {required this.id,
      required this.namaProduk,
      required this.harga,
      required this.deskripsi});

  @override
  List<Object?> get props => [id, namaProduk, harga, deskripsi];
}
