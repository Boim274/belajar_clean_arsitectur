import 'package:belajar_clean_arsitectur/features/kategori_produk/data/datasources/kategori_produk_datasource.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/repositories/kategori_produk_repo.dart';
import 'package:dartz/dartz.dart';

class KategoriProdukRepoImpl implements KategoriProdukRepo {
  final KategoriProdukRemoteDataSource kategoriProdukRemoteDataSource;

  KategoriProdukRepoImpl({required this.kategoriProdukRemoteDataSource});
  @override
  Future<Either<Exception, void>> addKategoriProduk(
      {required KategoriProdukModel kategoriProduk}) async {
    try {
      final data = await kategoriProdukRemoteDataSource.addKategoriProduk(
          kategoriProduk: kategoriProduk);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteKategoriProduk(
      {required String id}) async {
    try {
      final data =
          await kategoriProdukRemoteDataSource.deleteKategoriProduk(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editKategoriProduk(
      {required KategoriProdukModel kategoriProduk}) async {
    try {
      final data = await kategoriProdukRemoteDataSource.editKategoriProduk(
          kategoriProduk: kategoriProduk);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<KategoriProduk>>> getAllKategoriProduk() async {
    try {
      final data = await kategoriProdukRemoteDataSource.getAllKategoriProduk();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, KategoriProduk>> getKategoriProdukById(
      {required String id}) async {
    try {
      final data =
          await kategoriProdukRemoteDataSource.getKategoriProdukById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}
