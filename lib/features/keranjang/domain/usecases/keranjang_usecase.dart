import 'package:belajar_clean_arsitectur/features/keranjang/data/models/keranjang_model.dart';
import 'package:belajar_clean_arsitectur/features/keranjang/domain/entities/keranjang.dart';
import 'package:belajar_clean_arsitectur/features/keranjang/domain/repositories/keranjang_repo.dart';
import 'package:dartz/dartz.dart';

class KeranjangUsecasesGetAll {
  final KeranjangRepo keranjangRepositories;

  KeranjangUsecasesGetAll({required this.keranjangRepositories});

  Future<Either<Exception, List<Keranjang>>> execute() async {
    return await keranjangRepositories.getAllkeranjang();
  }
}

class KeranjangUsecasesGetById {
  final KeranjangRepo keranjangRepositories;

  KeranjangUsecasesGetById({required this.keranjangRepositories});

  Future<Either<Exception, Keranjang>> execute({required String id}) async {
    return await keranjangRepositories.getkeranjangById(id: id);
  }
}

class KeranjangUsecasesAddKeranjang {
  final KeranjangRepo keranjangRepositories;

  KeranjangUsecasesAddKeranjang({required this.keranjangRepositories});

  Future<Either<Exception, void>> execute(
      {required KeranjangModel keranjang}) async {
    return await keranjangRepositories.addKeranjang(keranjang: keranjang);
  }
}

class KeranjangUsecasesEditKeranjang {
  final KeranjangRepo keranjangRepositories;

  KeranjangUsecasesEditKeranjang({required this.keranjangRepositories});

  Future<Either<Exception, void>> execute(
      {required KeranjangModel keranjang}) async {
    return await keranjangRepositories.editKeranjang(keranjang: keranjang);
  }
}

class KeranjangUsecasesDeleteKeranjang {
  final KeranjangRepo keranjangRepositories;

  KeranjangUsecasesDeleteKeranjang({required this.keranjangRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await keranjangRepositories.deleteKeranjang(id: id);
  }
}


