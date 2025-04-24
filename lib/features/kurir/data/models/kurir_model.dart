import 'package:belajar_clean_arsitectur/features/kurir/domain/entities/kurir.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KurirModel extends Kurir {
  final bool isNew;

  const KurirModel({
    required super.id,
    required super.namaKurir,
    required super.nomorTlp,
    required super.email,
    required super.layanan,
    super.gudangId,
    super.createdAt,
    super.updatedAt,
    this.isNew = false,
  });

  factory KurirModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return KurirModel(
      id: doc.id,
      namaKurir: data['namaKurir'] ?? '',
      nomorTlp: data['nomorTlp'] ?? '',
      email: data['email'] ?? '',
      layanan: data['layanan'] ?? '',
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
      'namaKurir': namaKurir,
      'nomorTlp': nomorTlp,
      'email': email,
      'layanan': layanan,
      'gudangId': gudangId,
      'createdAt': isNew
          ? FieldValue.serverTimestamp()
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
