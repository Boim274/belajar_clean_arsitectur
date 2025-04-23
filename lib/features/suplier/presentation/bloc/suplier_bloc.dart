import 'package:belajar_clean_arsitectur/features/suplier/data/models/suplier_model.dart';
import 'package:belajar_clean_arsitectur/features/suplier/domain/entities/suplier.dart';
import 'package:belajar_clean_arsitectur/features/suplier/domain/usecases/suplier_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'suplier_event.dart';
part 'suplier_state.dart';

class SuplierBloc extends Bloc<SuplierEvent, SuplierState> {
  final SuplierUsecaseAddSuplier suplierUsecaseAdd;
  final SuplierUsecaseEditSuplier suplierUsecaseEdit;
  final SuplierUsecaseDeleteSuplier suplierUsecaseDelete;
  final SuplierUsecaseGetAll suplierUsecaseGetAll;
  final SuplierUsecaseGetById suplierUsecaseGetById;
  SuplierBloc(
      {required this.suplierUsecaseAdd,
      required this.suplierUsecaseEdit,
      required this.suplierUsecaseDelete,
      required this.suplierUsecaseGetAll,
      required this.suplierUsecaseGetById})
      : super(SuplierInitial()) {
    on<SuplierEventAdd>((event, emit) async {
      emit(SuplierStateLoading());
      final data = await suplierUsecaseAdd.execute(suplier: event.suplierModel);
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateSuccess());
        },
      );
    });
    on<SuplierEventEdit>((event, emit) async {
      emit(SuplierStateLoading());
      final data =
          await suplierUsecaseEdit.execute(suplier: event.suplierModel);
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateSuccess());
        },
      );
    });
    on<SuplierEventDelete>((event, emit) async {
      emit(SuplierStateLoading());
      final data = await suplierUsecaseDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateSuccess());
        },
      );
    });
    on<SuplierEventGetAll>((event, emit) async {
      emit(SuplierStateLoading());
      final data = await suplierUsecaseGetAll.execute();
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateLoadedAll(supliers: r));
        },
      );
    });
    on<SuplierEventGetById>((event, emit) async {
      emit(SuplierStateLoading());
      final data = await suplierUsecaseGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateLoaded(suplier: r));
        },
      );
    });
  }
}
