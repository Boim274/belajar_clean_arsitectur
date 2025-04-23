import 'package:belajar_clean_arsitectur/features/Auth/data/datasources/auth_datasource.dart';
import 'package:belajar_clean_arsitectur/features/Auth/data/repositories/auth_repositories_implementation.dart';
import 'package:belajar_clean_arsitectur/features/Auth/domain/repositories/users_repositories.dart';
import 'package:belajar_clean_arsitectur/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:belajar_clean_arsitectur/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:belajar_clean_arsitectur/features/gudang/data/datasources/gudang_datasource.dart';
import 'package:belajar_clean_arsitectur/features/gudang/data/repositories/gudang_repositorie.dart';
import 'package:belajar_clean_arsitectur/features/gudang/domain/repositories/gudang_repositorie.dart';
import 'package:belajar_clean_arsitectur/features/gudang/domain/usecases/gudang_usecase.dart';
import 'package:belajar_clean_arsitectur/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/data/datasources/jenis_datasource.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/data/repositories/jenis_repositorie.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/repositories/jenis_repositorie.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/usecases/jenis_usecase.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/presentation/bloc/jenis_produk_bloc.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/data/datasources/kategori_produk_datasource.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/data/repositories/kategori_produk_repo_impl.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/repositories/kategori_produk_repo.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/usecases/kategori_produk_usecase.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/presentation/bloc/kategori_produk_bloc.dart';
import 'package:belajar_clean_arsitectur/features/kurir/data/datasources/kurir_datasource.dart';
import 'package:belajar_clean_arsitectur/features/kurir/data/repositories/kurir_repositorie.dart';
import 'package:belajar_clean_arsitectur/features/kurir/domain/repositories/kurir_repositorie.dart';
import 'package:belajar_clean_arsitectur/features/kurir/domain/usecases/kurir_usecase.dart';
import 'package:belajar_clean_arsitectur/features/kurir/presentation/bloc/kurir_bloc.dart';
import 'package:belajar_clean_arsitectur/features/produk/data/datasources/produk_datasource.dart';
import 'package:belajar_clean_arsitectur/features/produk/data/repositories/produk_repo_impl.dart';
import 'package:belajar_clean_arsitectur/features/produk/domain/repositories/produk_repositories.dart';
import 'package:belajar_clean_arsitectur/features/produk/domain/usecases/produk_usecases.dart';
import 'package:belajar_clean_arsitectur/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:belajar_clean_arsitectur/features/suplier/data/datasources/suplier_datasource.dart';
import 'package:belajar_clean_arsitectur/features/suplier/data/repositories/suplier_repo_impl.dart';
import 'package:belajar_clean_arsitectur/features/suplier/domain/repositories/suplier_repositorie.dart';
import 'package:belajar_clean_arsitectur/features/suplier/domain/usecases/suplier_usecase.dart';
import 'package:belajar_clean_arsitectur/features/suplier/presentation/bloc/suplier_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

var myinjection = GetIt.instance;
Future<void> init() async {
  myinjection.registerLazySingleton(() => FirebaseAuth.instance);
  myinjection.registerLazySingleton(() => FirebaseFirestore.instance);
  // myinjection.registerLazySingleton(() => FirebaseStorage.instance);
//-------------------------------------------------------------------------------------------
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
//-------------------------------------------------------------------------------------------
  /// FEATURE - KATEGORI PRODUK
  // BLOC
  myinjection.registerFactory(
    () => KategoriProdukBloc(
      kategoriProdukUsecaseAdd: myinjection(),
      kategoriProdukUsecaseEdit: myinjection(),
      kategoriProdukUsecaseDelete: myinjection(),
      kategoriProdukUsecaseGetAll: myinjection(),
      kategoriProdukUsecaseGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecaseAddKategoriProduk(
        kategoriProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecaseEditKategoriProduk(
        kategoriProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecaseDeleteKategoriProduk(
        kategoriProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecaseGetAll(kategoriProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecaseGetById(kategoriProdukRepo: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<KategoriProdukRepo>(
    () => KategoriProdukRepoImpl(kategoriProdukRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<KategoriProdukRemoteDataSource>(() =>
      KategoriProdukRemoteDataSourceImplementation(
          firebaseFirestore: myinjection()));
//-------------------------------------------------------------------------------------------
  /// FEATURE - JENIS PRODUK
  // BLOC
  myinjection.registerFactory(
    () => JenisProdukBloc(
      jenisUsecaseAddJenis: myinjection(),
      jenisUsecaseEditJenis: myinjection(),
      jenisUsecaseDeleteJenis: myinjection(),
      jenisUsecaseGetAll: myinjection(),
      jenisUsecaseGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => JenisUsecaseAddJenis(jenisRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => JenisUsecaseEditJenis(jenisRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => JenisUsecaseDeleteJenis(jenisRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => JenisUsecaseGetAll(jenisRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => JenisUsecaseGetById(jenisRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<JenisRepositories>(
    () => JenisRepoImpl(jenisRemoteDatasource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<JenisRemoteDatasource>(() =>
      JenisRemoteDataSourceImplementation(firebaseFirestore: myinjection()));
//-------------------------------------------------------------------------------------------
  /// FEATURE - SUPLIER
  // BLOC
  myinjection.registerFactory(
    () => SuplierBloc(
      suplierUsecaseAdd: myinjection(),
      suplierUsecaseEdit: myinjection(),
      suplierUsecaseDelete: myinjection(),
      suplierUsecaseGetAll: myinjection(),
      suplierUsecaseGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => SuplierUsecaseAddSuplier(suplierRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecaseEditSuplier(suplierRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecaseDeleteSuplier(suplierRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecaseGetAll(suplierRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecaseGetById(suplierRepositorie: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<SuplierRepositorie>(
    () => SuplierRepoImpl(suplierRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<SuplierRemoteDataSource>(() =>
      SuplierRemoteDataSourceImplementation(firebaseFirestore: myinjection()));

  //-------------------------------------------------------------------------------------------
  /// FEATURE - GUDANG
  // BLOC
  myinjection.registerFactory(
    () => GudangBloc(
      gudangUsecaseAdd: myinjection(),
      gudangUsecaseEdit: myinjection(),
      gudangUsecaseDelete: myinjection(),
      gudangUsecaseGetAll: myinjection(),
      gudangUsecaseGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => GudangUsecaseAddGudang(gudangRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecaseEditGudang(gudangRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecaseDeleteGudang(gudangRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecaseGetAll(gudangRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecaseGetById(gudangRepositorie: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<GudangRepositorie>(
    () => GudangRepoImpl(gudangRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<GudangRemoteDataSource>(() =>
      GudangRemoteDataSourceImplementation(firebaseFirestore: myinjection()));

  //-------------------------------------------------------------------------------------------
  /// FEATURE - KURIR
  // BLOC
  myinjection.registerFactory(
    () => KurirBloc(
      kurirUsecaseAdd: myinjection(),
      kurirUsecaseEdit: myinjection(),
      kurirUsecaseDelete: myinjection(),
      kurirUsecaseGetAll: myinjection(),
      kurirUsecaseGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => KurirUsecaseAddKurir(kurirRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecaseEditKurir(kurirRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecaseDeleteKurir(kurirRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecaseGetAll(kurirRepositorie: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecaseGetById(kurirRepositorie: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<KurirRepositorie>(
    () => KurirRepoImpl(kurirRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<KurirRemoteDataSource>(() =>
      KurirRemoteDataSourceImplementation(firebaseFirestore: myinjection()));
}
