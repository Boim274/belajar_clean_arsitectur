import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/entities/jenis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JenisModel extends Jenis {
  const JenisModel({
    required super.id,
    required super.namaJenis,
    required super.deskripsi,
    super.createdAt,
    super.updatedAt,
  });

  factory JenisModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return JenisModel(
      id: doc.id,
      namaJenis: data['namaJenis'],
      deskripsi: data['deskripsi'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updateAt'] != null
          ? (data['updateAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFireStore({bool isUpdate = false}) {
    return {
      'namaJenis': namaJenis,
      'deskripsi': deskripsi,
      'createdAt':
          isUpdate ? createdAt : createdAt ?? FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp(),
    };
  }
}
