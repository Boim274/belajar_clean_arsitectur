import 'package:belajar_clean_arsitectur/features/produk/domain/entities/produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdukModel extends Produk {
  final bool isNew;
  const ProdukModel({
    required super.id,
    required super.namaProduk,
    required super.harga,
    required super.deskripsi,
    super.kategoriId,
    super.jenisId,
    super.gudangId,
    super.createdAt,
    super.updatedAt,
    this.isNew = false,
  });

  factory ProdukModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProdukModel(
      id: doc.id,
      namaProduk: data['namaProduk'],
      harga: data['harga'],
      deskripsi: data['deskripsi'],
      kategoriId: data['kategoriId'] ?? '',
      jenisId: data['jenisId'] ?? '',
      gudangId: data['gudangId'] ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      isNew: false,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'namaProduk': namaProduk,
      'harga': harga,
      'deskripsi': deskripsi,
      'kategoriId': kategoriId ?? '',
      'jenisId': jenisId ?? '',
      'gudangId': gudangId ?? '',
      'createdAt': isNew
          ? FieldValue.serverTimestamp()
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
