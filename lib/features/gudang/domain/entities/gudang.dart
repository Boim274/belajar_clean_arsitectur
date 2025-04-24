import 'package:equatable/equatable.dart';
import 'package:flutter/src/material/dropdown.dart';

class Gudang extends Equatable {
  final String id;
  final String? suplierId;
  final String namaGudang;
  final String alamat;
  final String nomorTlp;
  final String kapasitas;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Gudang(
      {required this.id,
      this.suplierId,
      required this.namaGudang,
      required this.alamat,
      required this.nomorTlp,
      required this.kapasitas,
      this.createdAt,
      this.updatedAt});

  @override
  List<Object?> get props => [
        id,
        suplierId,
        namaGudang,
        alamat,
        nomorTlp,
        kapasitas,
        createdAt,
        updatedAt
      ];

  map(DropdownMenuItem<String> Function(dynamic gudang) param0) {}
}
