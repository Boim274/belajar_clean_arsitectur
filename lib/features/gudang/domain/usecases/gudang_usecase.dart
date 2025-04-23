import 'package:belajar_clean_arsitectur/features/gudang/data/models/gudang_model.dart';
import 'package:belajar_clean_arsitectur/features/gudang/domain/entities/gudang.dart';
import 'package:belajar_clean_arsitectur/features/gudang/domain/repositories/gudang_repositorie.dart';
import 'package:dartz/dartz.dart';

class GudangUsecaseGetAll {
  final GudangRepositorie gudangRepositorie;

  GudangUsecaseGetAll({required this.gudangRepositorie});

  Future<Either<Exception, List<Gudang>>> execute() async {
    return await gudangRepositorie.getAllGudang();
  }
}

class GudangUsecaseGetById {
  final GudangRepositorie gudangRepositorie;

  GudangUsecaseGetById({required this.gudangRepositorie});

  Future<Either<Exception, Gudang>> execute({required String id}) async {
    return await gudangRepositorie.getGudangById(id: id);
  }
}

class GudangUsecaseAddGudang {
  final GudangRepositorie gudangRepositorie;

  GudangUsecaseAddGudang({required this.gudangRepositorie});

  Future<Either<Exception, void>> execute({required GudangModel gudang}) async {
    return await gudangRepositorie.addGudang(gudang: gudang);
  }
}

class GudangUsecaseEditGudang {
  final GudangRepositorie gudangRepositorie;

  GudangUsecaseEditGudang({required this.gudangRepositorie});

  Future<Either<Exception, void>> execute({required GudangModel gudang}) async {
    return await gudangRepositorie.editGudang(gudang: gudang);
  }
}

class GudangUsecaseDeleteGudang {
  final GudangRepositorie gudangRepositorie;

  GudangUsecaseDeleteGudang({required this.gudangRepositorie});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await gudangRepositorie.deleteGudang(id: id);
  }
}
