import 'package:belajar_clean_arsitectur/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/repositories/kategori_produk_repo.dart';
import 'package:dartz/dartz.dart';

class KategoriProdukUsecaseGetAll {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecaseGetAll({required this.kategoriProdukRepo});

  Future<Either<Exception, List<KategoriProduk>>> execute() async {
    return await kategoriProdukRepo.getAllKategoriProduk();
  }
}

class KategoriProdukUsecaseGetById {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecaseGetById({required this.kategoriProdukRepo});

  Future<Either<Exception, KategoriProduk>> execute(
      {required String id}) async {
    return await kategoriProdukRepo.getKategoriProdukById(id: id);
  }
}

class KategoriProdukUsecaseAddKategoriProduk {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecaseAddKategoriProduk({required this.kategoriProdukRepo});
  Future<Either<Exception, void>> execute(
      {required KategoriProdukModel kategoriProduk}) async {
    return await kategoriProdukRepo.addKategoriProduk(
        kategoriProduk: kategoriProduk);
  }
}

class KategoriProdukUsecaseEditKategoriProduk {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecaseEditKategoriProduk({required this.kategoriProdukRepo});

  Future<Either<Exception, void>> execute(
      {required KategoriProdukModel kategoriProduk}) async {
    return await kategoriProdukRepo.editKategoriProduk(
        kategoriProduk: kategoriProduk);
  }
}

class KategoriProdukUsecaseDeleteKategoriProduk {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecaseDeleteKategoriProduk({required this.kategoriProdukRepo});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await kategoriProdukRepo.deleteKategoriProduk(id: id);
  }
}
