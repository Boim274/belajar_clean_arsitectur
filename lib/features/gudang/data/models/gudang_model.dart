import 'package:belajar_clean_arsitectur/features/gudang/domain/entities/gudang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GudangModel extends Gudang {
  final bool isNew;

  const GudangModel({
    required super.id,
    super.suplierId,
    required super.namaGudang,
    required super.alamat,
    required super.nomorTlp,
    required super.kapasitas,
    super.createdAt,
    super.updatedAt,
    this.isNew = false,
  });

  factory GudangModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return GudangModel(
      id: doc.id,
      suplierId: data['suplierId'] ?? '',
      namaGudang: data['namaGudang'] ?? '',
      alamat: data['alamat'] ?? '',
      nomorTlp: data['nomorTlp'] ?? '',
      kapasitas: data['kapasitas'] ?? '',
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
      'suplierId': suplierId,
      'namaGudang': namaGudang,
      'alamat': alamat,
      'nomorTlp': nomorTlp,
      'kapasitas': kapasitas,
      'createdAt': isNew
          ? FieldValue.serverTimestamp()
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
