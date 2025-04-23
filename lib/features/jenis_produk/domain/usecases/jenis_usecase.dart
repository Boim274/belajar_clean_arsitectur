import 'package:belajar_clean_arsitectur/features/jenis_produk/data/models/jenis_model.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/entities/jenis.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/repositories/jenis_repositorie.dart';
import 'package:dartz/dartz.dart';

class JenisUsecaseGetAll {
  final JenisRepositories jenisRepositories;

  JenisUsecaseGetAll({required this.jenisRepositories});

  Future<Either<Exception, List<Jenis>>> execute() async {
    return await jenisRepositories.getAllJenis();
  }
}

class JenisUsecaseGetById {
  final JenisRepositories jenisRepositories;

  JenisUsecaseGetById({required this.jenisRepositories});
  Future<Either<Exception, Jenis>> execute({required String id}) async {
    return await jenisRepositories.getJenisById(id: id);
  }
}

class JenisUsecaseAddJenis {
  final JenisRepositories jenisRepositories;

  JenisUsecaseAddJenis({required this.jenisRepositories});

  Future<Either<Exception, void>> execute({required JenisModel jenis}) async {
    return await jenisRepositories.addJenis(jenis: jenis);
  }
}

class JenisUsecaseEditJenis {
  final JenisRepositories jenisRepositories;

  JenisUsecaseEditJenis({required this.jenisRepositories});

  Future<Either<Exception, void>> execute({required JenisModel jenis}) async {
    return await jenisRepositories.editJenis(jenis: jenis);
  }
}

class JenisUsecaseDeleteJenis {
  final JenisRepositories jenisRepositories;

  JenisUsecaseDeleteJenis({required this.jenisRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await jenisRepositories.deleteJenis(id: id);
  }
}
