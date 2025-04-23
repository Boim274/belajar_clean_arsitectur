import 'package:belajar_clean_arsitectur/features/gudang/data/models/gudang_model.dart';
import 'package:belajar_clean_arsitectur/features/gudang/domain/entities/gudang.dart';
import 'package:belajar_clean_arsitectur/features/gudang/domain/usecases/gudang_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gudang_event.dart';
part 'gudang_state.dart';

class GudangBloc extends Bloc<GudangEvent, GudangState> {
  final GudangUsecaseAddGudang gudangUsecaseAdd;
  final GudangUsecaseEditGudang gudangUsecaseEdit;
  final GudangUsecaseDeleteGudang gudangUsecaseDelete;
  final GudangUsecaseGetAll gudangUsecaseGetAll;
  final GudangUsecaseGetById gudangUsecaseGetById;
  GudangBloc(
      {required this.gudangUsecaseAdd,
      required this.gudangUsecaseEdit,
      required this.gudangUsecaseDelete,
      required this.gudangUsecaseGetAll,
      required this.gudangUsecaseGetById})
      : super(GudangInitial()) {
    on<GudangEventAdd>((event, emit) async {
      emit(GudangStateLoading());
      final data = await gudangUsecaseAdd.execute(gudang: event.gudangModel);
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateSuccess());
        },
      );
    });
    on<GudangEventEdit>((event, emit) async {
      emit(GudangStateLoading());
      final data = await gudangUsecaseEdit.execute(gudang: event.gudangModel);
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateSuccess());
        },
      );
    });
    on<GudangEventDelete>((event, emit) async {
      emit(GudangStateLoading());
      final data = await gudangUsecaseDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateSuccess());
        },
      );
    });
    on<GudangEventGetAll>((event, emit) async {
      emit(GudangStateLoading());
      final data = await gudangUsecaseGetAll.execute();
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateLoadedAll(gudangs: r));
        },
      );
    });
    on<GudangEventGetById>((event, emit) async {
      emit(GudangStateLoading());
      final data = await gudangUsecaseGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateLoaded(gudang: r));
        },
      );
    });
  }
}
