import 'package:belajar_clean_arsitectur/features/suplier/domain/entities/suplier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuplierModel extends Suplier {
  final bool isNew;

  const SuplierModel({
    required super.id,
    required super.namaSuplier,
    required super.nomorTlp,
    super.createdAt,
    super.updatedAt,
    this.isNew = false,
  });

  factory SuplierModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return SuplierModel(
      id: doc.id,
      namaSuplier: data['namaSuplier'] ?? '',
      nomorTlp: data['nomorTlp'] ?? '',
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
      'namaSuplier': namaSuplier,
      'nomorTlp': nomorTlp,
      'createdAt': isNew
          ? FieldValue.serverTimestamp()
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
