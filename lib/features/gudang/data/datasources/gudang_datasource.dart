import 'package:belajar_clean_arsitectur/features/gudang/data/models/gudang_model.dart';
import 'package:belajar_clean_arsitectur/features/gudang/domain/entities/gudang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GudangRemoteDataSource {
  Future<List<Gudang>> getAllGudang();
  Future<Gudang> getGudangById({required String id});
  Future<void> addGudang({required GudangModel gudang});
  Future<void> editGudang({required GudangModel gudang});
  Future<void> deleteGudang({required String id});
}

class GudangRemoteDataSourceImplementation implements GudangRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  GudangRemoteDataSourceImplementation({required this.firebaseFirestore});
  @override
  Future<void> addGudang({required GudangModel gudang}) async {
    await firebaseFirestore.collection('Gudangs').add(gudang.toFireStore());
  }

  @override
  Future<void> deleteGudang({required String id}) async {
    await firebaseFirestore.collection('Gudangs').doc(id).delete();
  }

  @override
  Future<void> editGudang({required GudangModel gudang}) async {
    await firebaseFirestore
        .collection('Gudangs')
        .doc(gudang.id)
        .update(gudang.toFireStore());
  }

  @override
  Future<List<Gudang>> getAllGudang() async {
    final data = await firebaseFirestore.collection('Gudangs').get();
    return data.docs
        .map(
          (e) => GudangModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Gudang> getGudangById({required String id}) async {
    final data = await firebaseFirestore.collection('Gudangs').doc(id).get();
    return GudangModel.fromFirestore(data);
  }
}
