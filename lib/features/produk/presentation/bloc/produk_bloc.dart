import 'package:belajar_clean_arsitectur/features/produk/data/models/produk_model.dart';
import 'package:belajar_clean_arsitectur/features/produk/domain/entities/produk.dart';
import 'package:belajar_clean_arsitectur/features/produk/domain/usecases/produk_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  final ProdukUsecasesAddProduk produkUsecasesAdd;
  final ProdukUsecasesEditProduk produkUsecasesEditProduk;
  final ProdukUsecasesDeleteProduk produkUsecasesDeleteProduk;
  final ProdukUsecasesGetAll produkUsecasesGetAll;
  final ProdukUsecasesGetById produkUsecasesGetById;

  ProdukBloc({
    required this.produkUsecasesAdd,
    required this.produkUsecasesEditProduk,
    required this.produkUsecasesDeleteProduk,
    required this.produkUsecasesGetAll,
    required this.produkUsecasesGetById,
  }) : super(ProdukInitial()) {
    on<ProdukEventAdd>((event, emit) async {
      emit(ProdukStateLoading());
      final data = await produkUsecasesAdd.execute(produk: event.produkModel);
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateSuccess());
          add(ProdukEventGetAll()); // Reload produk setelah berhasil tambah
        },
      );
    });

    on<ProdukEventEdit>((event, emit) async {
      emit(ProdukStateLoading());
      final data =
          await produkUsecasesEditProduk.execute(produk: event.produkModel);
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateSuccess());
          add(ProdukEventGetAll()); // Memuat ulang produk setelah edit
        },
      );
    });

    on<ProdukEventDelete>((event, emit) async {
      emit(ProdukStateLoading());
      final data = await produkUsecasesDeleteProduk.execute(id: event.id);
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateSuccess());
          add(ProdukEventGetAll()); // Memuat ulang produk setelah delete
        },
      );
    });

    on<ProdukEventGetAll>((event, emit) async {
      emit(ProdukStateLoading());
      final data = await produkUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateLoadedAll(produks: r));
        },
      );
    });

    on<ProdukEventGetById>((event, emit) async {
      emit(ProdukStateLoading());
      final data = await produkUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateLoaded(produk: r));
        },
      );
    });
  }
}
