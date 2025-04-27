import 'package:belajar_clean_arsitectur/features/favorite/domain/entities/favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel extends Favorite {
  final bool isNew;

  const FavoriteModel({
    required super.id,
    required super.produkId,
    super.isFavorite,
    super.createdAt,
    super.updatedAt,
    this.isNew = false,
  });

  factory FavoriteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      id: doc.id,
      produkId: data['produkId'] ?? '',
      isFavorite: data['isFavorite'] ?? false, // Default false jika null
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
      'produkId': produkId,
      'isFavorite': isFavorite,
      'createdAt': isNew
          ? FieldValue.serverTimestamp() // Gunakan waktu server jika baru
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue
                  .serverTimestamp()), // Jika createdAt null, gunakan waktu server
      'updatedAt':
          FieldValue.serverTimestamp(), // Setiap update, timestamp baru
    };
  }
}
