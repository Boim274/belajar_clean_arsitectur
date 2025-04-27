import 'package:belajar_clean_arsitectur/features/favorite/data/models/favorite_model.dart';
import 'package:belajar_clean_arsitectur/features/favorite/domain/entities/favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  FavoriteRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addFavorite({required FavoriteModel favorite}) async {
    await firebaseFirestore.collection('Favorites').add(favorite.toFireStore());
  }

  @override
  Future<void> deleteFavorite({required String id}) async {
    await firebaseFirestore.collection('Favorites').doc(id).delete();
  }

  @override
  Future<void> editFavorite({required FavoriteModel favorite}) async {
    await firebaseFirestore
        .collection('Favorites')
        .doc(favorite.id)
        .update(favorite.toFireStore());
  }

  @override
  Future<List<Favorite>> getAllFavorite() async {
    final data = await firebaseFirestore.collection('Favorites').get();
    return data.docs
        .map(
          (e) => FavoriteModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Favorite> getFavoriteById({required String id}) async {
    final data = await firebaseFirestore.collection('Favorites').doc(id).get();
    return FavoriteModel.fromFirestore(data);
  }
}
