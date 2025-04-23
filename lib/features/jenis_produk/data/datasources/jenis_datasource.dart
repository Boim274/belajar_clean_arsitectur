import 'package:belajar_clean_arsitectur/features/jenis_produk/data/models/jenis_model.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/entities/jenis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class JenisRemoteDatasource {
  Future<List<Jenis>> getAllJenis();
  Future<Jenis> getJenisById({required String id});
  Future<void> addJenis({required JenisModel jenis});
  Future<void> editJenis({required JenisModel jenis});
  Future<void> deleteJenis({required String id});
}

class JenisRemoteDataSourceImplementation implements JenisRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;

  JenisRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addJenis({required JenisModel jenis}) async {
    await firebaseFirestore
        .collection('jenis-produks')
        .add(jenis.toFireStore());
  }

  @override
  Future<void> deleteJenis({required String id}) async {
    await firebaseFirestore.collection('jenis-produks').doc(id).delete();
  }

  @override
  Future<void> editJenis({required JenisModel jenis}) async {
    await firebaseFirestore
        .collection('jenis-produks')
        .doc(jenis.id)
        .update(jenis.toFireStore());
  }

  @override
  Future<List<Jenis>> getAllJenis() async {
    final data = await firebaseFirestore.collection('jenis-produks').get();
    return data.docs
        .map(
          (e) => JenisModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Jenis> getJenisById({required String id}) async {
    final data =
        await firebaseFirestore.collection('jenis-produks').doc(id).get();
    return JenisModel.fromFirestore(data);
  }
}
