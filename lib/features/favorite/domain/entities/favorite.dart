import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String id;
  final String produkId;
  final bool isFavorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Favorite({
    required this.id,
    required this.produkId,
    this.isFavorite = false, // Default value for isFavorite
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        produkId,
        isFavorite,
        createdAt,
        updatedAt,
      ];
}
