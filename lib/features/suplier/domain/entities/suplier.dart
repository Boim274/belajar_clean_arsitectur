import 'package:equatable/equatable.dart';

class Suplier extends Equatable {
  final String id;
  final String namaSuplier;
  final String nomorTlp;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Suplier(
      {required this.id,
      required this.namaSuplier,
      required this.nomorTlp,
      this.createdAt,
      this.updatedAt});

  @override
  List<Object?> get props => [id, namaSuplier, nomorTlp, createdAt, updatedAt];
}
