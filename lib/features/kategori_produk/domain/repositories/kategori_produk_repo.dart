import 'package:belajar_clean_arsitectur/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:dartz/dartz.dart';

abstract class KategoriProdukRepo {
  Future<Either<Exception, List<KategoriProduk>>> getAllKategoriProduk();
  Future<Either<Exception, KategoriProduk>> getKategoriProdukById(
      {required String id});
  Future<Either<Exception, void>> addKategoriProduk(
      {required KategoriProdukModel kategoriProduk});
  Future<Either<Exception, void>> editKategoriProduk(
      {required KategoriProdukModel kategoriProduk});
  Future<Either<Exception, void>> deleteKategoriProduk({required String id});
}
