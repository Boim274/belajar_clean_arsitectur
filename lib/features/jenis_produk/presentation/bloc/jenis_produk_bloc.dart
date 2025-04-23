import 'package:belajar_clean_arsitectur/features/jenis_produk/data/models/jenis_model.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/entities/jenis.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/domain/usecases/jenis_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'jenis_produk_event.dart';
part 'jenis_produk_state.dart';

class JenisProdukBloc extends Bloc<JenisProdukEvent, JenisProdukState> {
  final JenisUsecaseAddJenis jenisUsecaseAddJenis;
  final JenisUsecaseEditJenis jenisUsecaseEditJenis;
  final JenisUsecaseDeleteJenis jenisUsecaseDeleteJenis;
  final JenisUsecaseGetAll jenisUsecaseGetAll;
  final JenisUsecaseGetById jenisUsecaseGetById;
  JenisProdukBloc(
      {required this.jenisUsecaseAddJenis,
      required this.jenisUsecaseEditJenis,
      required this.jenisUsecaseDeleteJenis,
      required this.jenisUsecaseGetAll,
      required this.jenisUsecaseGetById})
      : super(JenisProdukInitial()) {
    on<JenisEventAdd>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data = await jenisUsecaseAddJenis.execute(jenis: event.jenisModel);
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateSuccess());
        },
      );
    });
    on<JenisEventEdit>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data = await jenisUsecaseEditJenis.execute(jenis: event.jenisModel);
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateSuccess());
        },
      );
    });
    on<JenisEventDelete>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data = await jenisUsecaseDeleteJenis.execute(id: event.id);
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateSuccess());
        },
      );
    });
    on<JenisEventGetAll>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data = await jenisUsecaseGetAll.execute();
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateLoadedAll(jenis: r));
        },
      );
    });
    on<JenisEventGetById>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data = await jenisUsecaseGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateLoaded(jenis: r));
        },
      );
    });
  }
}
