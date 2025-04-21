import 'package:belajar_clean_arsitectur/features/Auth/data/datasources/auth_datasource.dart';
import 'package:belajar_clean_arsitectur/features/Auth/data/repositories/auth_repositories_implementation.dart';
import 'package:belajar_clean_arsitectur/features/Auth/domain/repositories/users_repositories.dart';
import 'package:belajar_clean_arsitectur/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:belajar_clean_arsitectur/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:belajar_clean_arsitectur/features/produk/data/datasources/produk_datasource.dart';
import 'package:belajar_clean_arsitectur/features/produk/data/repositories/produk_repo_impl.dart';
import 'package:belajar_clean_arsitectur/features/produk/domain/repositories/produk_repositories.dart';
import 'package:belajar_clean_arsitectur/features/produk/domain/usecases/produk_usecases.dart';
import 'package:belajar_clean_arsitectur/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

var myinjection = GetIt.instance;
Future<void> init() async {
  myinjection.registerLazySingleton(() => FirebaseAuth.instance);
  myinjection.registerLazySingleton(() => FirebaseFirestore.instance);
  // myinjection.registerLazySingleton(() => FirebaseStorage.instance);

  /// FEATURE - AUTH
  // BLOC
  myinjection.registerFactory(
    () => AuthBloc(
      signInWithEmail: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => SignInWithEmail(repository: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<AuthRepository>(
    () => AuthRepositoriesImplementation(dataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(firebaseAuth: myinjection()));

  /// FEATURE - PRODUK
  // BLOC
  myinjection.registerFactory(
    () => ProdukBloc(
        produkUsecasesAdd: myinjection(),
        produkUsecasesDeleteProduk: myinjection(),
        produkUsecasesEditProduk: myinjection(),
        produkUsecasesGetAll: myinjection(),
        produkUsecasesGetById: myinjection()),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => ProdukUsecasesAddProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesDeleteProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesEditProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesGetAll(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesGetById(produkRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<ProdukRepositories>(
    () => ProdukRepoImpl(produkRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<ProdukRemoteDataSource>(() =>
      ProdukRemoteDataSourceImplementation(firebaseFirestore: myinjection()));
}
