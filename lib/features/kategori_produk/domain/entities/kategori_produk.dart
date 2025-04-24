import 'package:equatable/equatable.dart';
import 'package:flutter/src/material/dropdown.dart';

class KategoriProduk extends Equatable {
  final String id;
  final String namaKategori;
  final String deskripsi;

  const KategoriProduk(
      {required this.id, required this.namaKategori, required this.deskripsi});

  @override
  List<Object?> get props => [id, namaKategori, deskripsi];

  map(DropdownMenuItem<String> Function(dynamic kategori) param0) {}
}
