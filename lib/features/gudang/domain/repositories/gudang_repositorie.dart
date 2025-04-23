import 'package:belajar_clean_arsitectur/features/gudang/data/models/gudang_model.dart';
import 'package:belajar_clean_arsitectur/features/gudang/domain/entities/gudang.dart';
import 'package:dartz/dartz.dart';

abstract class GudangRepositorie {
  Future<Either<Exception, List<Gudang>>> getAllGudang();
  Future<Either<Exception, Gudang>> getGudangById({required String id});
  Future<Either<Exception, void>> addGudang({required GudangModel gudang});
  Future<Either<Exception, void>> editGudang({required GudangModel gudang});
  Future<Either<Exception, void>> deleteGudang({required String id});
}
