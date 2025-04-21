import 'package:belajar_clean_arsitectur/features/produk/domain/entities/produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdukModel extends Produk {
  const ProdukModel(
      {required super.id,
      required super.namaProduk,
      required super.harga,
      required super.deskripsi});

  factory ProdukModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProdukModel(
        id: doc.id,
        namaProduk: data['namaProduk'],
        harga: data['harga'],
        deskripsi: data['deskripsi']);
  }

  Map<String, dynamic> toFireStore() {
    return {'namaProduk': namaProduk, 'harga': harga, 'deskripsi': deskripsi};
  }
}
