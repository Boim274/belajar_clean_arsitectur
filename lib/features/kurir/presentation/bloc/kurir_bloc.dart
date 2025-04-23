import 'package:belajar_clean_arsitectur/features/kurir/data/models/kurir_model.dart';
import 'package:belajar_clean_arsitectur/features/kurir/domain/entities/kurir.dart';
import 'package:belajar_clean_arsitectur/features/kurir/domain/usecases/kurir_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kurir_event.dart';
part 'kurir_state.dart';

class KurirBloc extends Bloc<KurirEvent, KurirState> {
  final KurirUsecaseAddKurir kurirUsecaseAdd;
  final KurirUsecaseEditKurir kurirUsecaseEdit;
  final KurirUsecaseDeleteKurir kurirUsecaseDelete;
  final KurirUsecaseGetAll kurirUsecaseGetAll;
  final KurirUsecaseGetById kurirUsecaseGetById;
  KurirBloc(
      {required this.kurirUsecaseAdd,
      required this.kurirUsecaseEdit,
      required this.kurirUsecaseDelete,
      required this.kurirUsecaseGetAll,
      required this.kurirUsecaseGetById})
      : super(KurirInitial()) {
    on<KurirEventAdd>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecaseAdd.execute(kurir: event.kurirModel);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateSuccess());
        },
      );
    });
    on<KurirEventEdit>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecaseEdit.execute(kurir: event.kurirModel);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateSuccess());
        },
      );
    });
    on<KurirEventDelete>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecaseDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateSuccess());
        },
      );
    });
    on<KurirEventGetAll>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecaseGetAll.execute();
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateLoadedAll(kurirs: r));
        },
      );
    });
    on<KurirEventGetById>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecaseGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateLoaded(kurir: r));
        },
      );
    });
  }
}
