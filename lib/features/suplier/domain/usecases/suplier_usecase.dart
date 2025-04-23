import 'package:belajar_clean_arsitectur/features/suplier/data/models/suplier_model.dart';
import 'package:belajar_clean_arsitectur/features/suplier/domain/entities/suplier.dart';
import 'package:belajar_clean_arsitectur/features/suplier/domain/repositories/suplier_repositorie.dart';
import 'package:dartz/dartz.dart';

class SuplierUsecaseGetAll {
  final SuplierRepositorie suplierRepositorie;

  SuplierUsecaseGetAll({required this.suplierRepositorie});

  Future<Either<Exception, List<Suplier>>> execute() async {
    return await suplierRepositorie.getAllSuplier();
  }
}

class SuplierUsecaseGetById {
  final SuplierRepositorie suplierRepositorie;

  SuplierUsecaseGetById({required this.suplierRepositorie});

  Future<Either<Exception, Suplier>> execute({required String id}) async {
    return await suplierRepositorie.getSuplierById(id: id);
  }
}

class SuplierUsecaseAddSuplier {
  final SuplierRepositorie suplierRepositorie;

  SuplierUsecaseAddSuplier({required this.suplierRepositorie});

  Future<Either<Exception, void>> execute(
      {required SuplierModel suplier}) async {
    return await suplierRepositorie.addSuplier(suplier: suplier);
  }
}

class SuplierUsecaseEditSuplier {
  final SuplierRepositorie suplierRepositorie;

  SuplierUsecaseEditSuplier({required this.suplierRepositorie});

  Future<Either<Exception, void>> execute(
      {required SuplierModel suplier}) async {
    return await suplierRepositorie.editSuplier(suplier: suplier);
  }
}

class SuplierUsecaseDeleteSuplier {
  final SuplierRepositorie suplierRepositorie;

  SuplierUsecaseDeleteSuplier({required this.suplierRepositorie});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await suplierRepositorie.deleteSuplier(id: id);
  }
}
