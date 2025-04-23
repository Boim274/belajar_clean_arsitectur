import 'package:belajar_clean_arsitectur/features/jenis_produk/data/models/jenis_model.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/entities/jenis.dart';

import 'package:dartz/dartz.dart';

abstract class JenisRepositories {
  Future<Either<Exception, List<Jenis>>> getAllJenis();
  Future<Either<Exception, Jenis>> getJenisById({required String id});
  Future<Either<Exception, void>> addJenis({required JenisModel jenis});
  Future<Either<Exception, void>> editJenis({required JenisModel jenis});
  Future<Either<Exception, void>> deleteJenis({required String id});
}
