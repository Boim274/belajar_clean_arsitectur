import 'package:belajar_clean_arsitectur/features/kurir/data/models/kurir_model.dart';
import 'package:belajar_clean_arsitectur/features/kurir/domain/entities/kurir.dart';
import 'package:belajar_clean_arsitectur/features/kurir/domain/repositories/kurir_repositorie.dart';
import 'package:dartz/dartz.dart';

class KurirUsecaseGetAll {
  final KurirRepositorie kurirRepositorie;

  KurirUsecaseGetAll({required this.kurirRepositorie});

  Future<Either<Exception, List<Kurir>>> execute() async {
    return await kurirRepositorie.getAllKurir();
  }
}

class KurirUsecaseGetById {
  final KurirRepositorie kurirRepositorie;

  KurirUsecaseGetById({required this.kurirRepositorie});

  Future<Either<Exception, Kurir>> execute({required String id}) async {
    return await kurirRepositorie.getKurirById(id: id);
  }
}

class KurirUsecaseAddKurir {
  final KurirRepositorie kurirRepositorie;

  KurirUsecaseAddKurir({required this.kurirRepositorie});

  Future<Either<Exception, void>> execute({required KurirModel kurir}) async {
    return await kurirRepositorie.addKurir(kurir: kurir);
  }
}

class KurirUsecaseEditKurir {
  final KurirRepositorie kurirRepositorie;

  KurirUsecaseEditKurir({required this.kurirRepositorie});

  Future<Either<Exception, void>> execute({required KurirModel kurir}) async {
    return await kurirRepositorie.editKurir(kurir: kurir);
  }
}

class KurirUsecaseDeleteKurir {
  final KurirRepositorie kurirRepositorie;

  KurirUsecaseDeleteKurir({required this.kurirRepositorie});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await kurirRepositorie.deleteKurir(id: id);
  }
}
