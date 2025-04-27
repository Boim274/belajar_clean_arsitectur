import 'package:equatable/equatable.dart';

class Keranjang extends Equatable {
  final String id;
  final String? produkId;
  final String namaProduk;
  final int quantity;
  final String harga;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Keranjang({
    required this.id,
    this.produkId,
    required this.namaProduk,
    required this.quantity,
    required this.harga,
    this.createdAt,
    this.updatedAt,
  });
  @override
  List<Object?> get props =>
      [id, produkId, namaProduk, quantity, harga, createdAt, updatedAt];
}
