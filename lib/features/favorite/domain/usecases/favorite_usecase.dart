import 'package:belajar_clean_arsitectur/features/favorite/data/models/favorite_model.dart';
import 'package:belajar_clean_arsitectur/features/favorite/domain/entities/favorite.dart';
import 'package:belajar_clean_arsitectur/features/favorite/domain/repositories/favorite_repo.dart';
import 'package:dartz/dartz.dart';

class FavoriteUsecasesGetAll {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesGetAll({required this.favoriteRepositories});

  Future<Either<Exception, List<Favorite>>> execute() async {
    return await favoriteRepositories.getAllFavorite();
  }
}

class FavoriteUsecasesGetById {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesGetById({required this.favoriteRepositories});

  Future<Either<Exception, Favorite>> execute({required String id}) async {
    return await favoriteRepositories.getFavoriteById(id: id);
  }
}

class FavoriteUsecasesAddFavorite {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesAddFavorite({required this.favoriteRepositories});

  Future<Either<Exception, void>> execute(
      {required FavoriteModel favorite}) async {
    return await favoriteRepositories.addFavorite(favorite: favorite);
  }
}

class FavoriteUsecasesEditFavorite {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesEditFavorite({required this.favoriteRepositories});

  Future<Either<Exception, void>> execute(
      {required FavoriteModel favorite}) async {
    return await favoriteRepositories.editFavorite(favorite: favorite);
  }
}

class FavoriteUsecasesDeleteFavorite {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesDeleteFavorite({required this.favoriteRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await favoriteRepositories.deleteFavorite(id: id);
  }
}
