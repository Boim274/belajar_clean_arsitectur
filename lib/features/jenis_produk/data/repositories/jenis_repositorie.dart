import 'package:belajar_clean_arsitectur/features/jenis_produk/data/datasources/jenis_datasource.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/data/models/jenis_model.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/entities/jenis.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/repositories/jenis_repositorie.dart';
import 'package:dartz/dartz.dart';

class JenisRepoImpl implements JenisRepositories {
  final JenisRemoteDatasource jenisRemoteDatasource;

  JenisRepoImpl({required this.jenisRemoteDatasource});

  @override
  Future<Either<Exception, void>> addJenis({required JenisModel jenis}) async {
    try {
      final data = await jenisRemoteDatasource.addJenis(jenis: jenis);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteJenis({required String id}) async {
    try {
      final data = await jenisRemoteDatasource.deleteJenis(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editJenis({required JenisModel jenis}) async {
    try {
      final data = await jenisRemoteDatasource.editJenis(jenis: jenis);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Jenis>>> getAllJenis() async {
    try {
      final data = await jenisRemoteDatasource.getAllJenis();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Jenis>> getJenisById({required String id}) async {
    try {
      final data = await jenisRemoteDatasource.getJenisById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}
