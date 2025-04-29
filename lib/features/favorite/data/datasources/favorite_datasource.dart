import 'package:belajar_clean_arsitectur/features/favorite/data/models/favorite_model.dart';
import 'package:belajar_clean_arsitectur/features/favorite/domain/entities/favorite.dart';
import 'package:belajar_clean_arsitectur/my_injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<Favorite>> getAllFavorite();
  Future<Favorite> getFavoriteById({required String id});
  // void tidak ada pengembalian
  Future<void> addFavorite({required FavoriteModel favorite});
  Future<void> editFavorite({required FavoriteModel favorite});
  Future<void> deleteFavorite({required String id});
}

class FavoriteRemoteDataSourceImplementation
    implements FavoriteRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;
  final user = myinjection<Box>();

  FavoriteRemoteDataSourceImplementation({required this.firebaseFirestore});

  // Tambahkan favorite ke subcollection user
  @override
  Future<void> addFavorite({required FavoriteModel favorite}) async {
    final favoriteCollection = firebaseFirestore
        .collection('users')
        .doc(user.get('uid'))
        .collection('favorite');

    final isProdukExist = await favoriteCollection
        .where('produkId', isEqualTo: favorite.produkId)
        .get();

    if (isProdukExist.docs.isEmpty) {
      await favoriteCollection.add(favorite.toFireStore());
    } else {
      throw Exception('Produk sudah ada di favorite');
    }
  }

 // Hapus favorite dari subcollection user
  @override
  Future<void> deleteFavorite({required String id}) async {
    await firebaseFirestore
        .collection('users')
        .doc(user.get('uid'))
        .collection('favorite')
        .doc(id)
        .delete();
  }

  //  Update favorite di subcollection user
  @override
  Future<void> editFavorite({required FavoriteModel favorite}) async {
    await firebaseFirestore
        .collection('users')
        .doc(user.get('uid'))
        .collection('favorite')
        .doc(favorite.id)
        .update(favorite.toFireStore());
  }

  // Ambil semua favorite dari subcollection user
  @override
  Future<List<Favorite>> getAllFavorite() async {
    final data = await firebaseFirestore
        .collection('users')
        .doc(user.get('uid'))
        .collection('favorite')
        .get();

    return data.docs.map((e) => FavoriteModel.fromFirestore(e)).toList();
  }

  // Ambil satu favorite dari subcollection user
  @override
  Future<Favorite> getFavoriteById({required String id}) async {
    final doc = await firebaseFirestore
        .collection('users')
        .doc(user.get('uid'))
        .collection('favorite')
        .doc(id)
        .get();

    return FavoriteModel.fromFirestore(doc);
  }
}
