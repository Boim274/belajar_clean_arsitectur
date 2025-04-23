import 'package:belajar_clean_arsitectur/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class KategoriProdukRemoteDataSource {
  Future<List<KategoriProduk>> getAllKategoriProduk();
  Future<KategoriProduk> getKategoriProdukById({required String id});
  Future<void> addKategoriProduk({required KategoriProdukModel kategoriProduk});
  Future<void> editKategoriProduk(
      {required KategoriProdukModel kategoriProduk});
  Future<void> deleteKategoriProduk({required String id});
}

class KategoriProdukRemoteDataSourceImplementation
    implements KategoriProdukRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  KategoriProdukRemoteDataSourceImplementation(
      {required this.firebaseFirestore});
  @override
  Future<void> addKategoriProduk(
      {required KategoriProdukModel kategoriProduk}) async {
    await firebaseFirestore
        .collection('kategori-produks')
        .add(kategoriProduk.toFireStrore());
  }

  @override
  Future<void> deleteKategoriProduk({required String id}) async {
    await firebaseFirestore.collection('kategori-produks').doc(id).delete();
  }

  @override
  Future<void> editKategoriProduk(
      {required KategoriProdukModel kategoriProduk}) async {
    await firebaseFirestore
        .collection('kategori-produks')
        .doc(kategoriProduk.id)
        .update(kategoriProduk.toFireStrore());
  }

  @override
  Future<List<KategoriProduk>> getAllKategoriProduk() async {
    final data = await firebaseFirestore.collection('kategori-produks').get();
    return data.docs
        .map(
          (e) => KategoriProdukModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<KategoriProduk> getKategoriProdukById({required String id}) async {
    final data =
        await firebaseFirestore.collection('kategori-produks').doc(id).get();
    return KategoriProdukModel.fromFirestore(data);
  }
}
