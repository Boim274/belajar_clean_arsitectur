
import 'package:belajar_clean_arsitectur/features/suplier/data/models/suplier_model.dart';
import 'package:belajar_clean_arsitectur/features/suplier/domain/entities/suplier.dart';
import 'package:dartz/dartz.dart';

abstract class SuplierRepositorie {
  Future<Either<Exception, List<Suplier>>> getAllSuplier();
  Future<Either<Exception, Suplier>> getSuplierById({required String id});
  Future<Either<Exception, void>> addSuplier({required SuplierModel suplier});
  Future<Either<Exception, void>> editSuplier({required SuplierModel suplier});
  Future<Either<Exception, void>> deleteSuplier({required String id});
}
