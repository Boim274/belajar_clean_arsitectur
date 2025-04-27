import 'package:belajar_clean_arsitectur/features/favorite/data/models/favorite_model.dart';
import 'package:belajar_clean_arsitectur/features/favorite/domain/entities/favorite.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteRepositories {
  //future tipe data bisa banyak
  Future<Either<Exception, List<Favorite>>> getAllFavorite();
  Future<Either<Exception, Favorite>> getFavoriteById({required String id});
  Future<Either<Exception, void>> addFavorite(
      {required FavoriteModel favorite});
  Future<Either<Exception, void>> editFavorite(
      {required FavoriteModel favorite});
  Future<Either<Exception, void>> deleteFavorite({required String id});
}
