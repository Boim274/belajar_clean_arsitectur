import 'package:belajar_clean_arsitectur/features/keranjang/domain/entities/keranjang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KeranjangModel extends Keranjang {
  final bool isNew;
  KeranjangModel({
    required super.id,
    super.produkId,
    required super.namaProduk,
    required super.quantity,
    required super.harga,
    super.createdAt,
    super.updatedAt,
    this.isNew = false,
  });

  factory KeranjangModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return KeranjangModel(
      id: doc.id,
      produkId: data['produkId'] ?? '',
      namaProduk: data['namaProduk'],
      quantity: data['quantity'],
      harga: data['harga'],
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
      'produkId': produkId ?? '',
      'namaProduk': namaProduk,
      'quantity': quantity,
      'harga': harga,
      'createdAt': isNew
          ? FieldValue.serverTimestamp()
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
