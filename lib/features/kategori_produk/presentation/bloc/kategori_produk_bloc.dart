import 'package:belajar_clean_arsitectur/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/domain/usecases/kategori_produk_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kategori_produk_event.dart';
part 'kategori_produk_state.dart';

class KategoriProdukBloc
    extends Bloc<KategoriProdukEvent, KategoriProdukState> {
  final KategoriProdukUsecaseAddKategoriProduk kategoriProdukUsecaseAdd;
  final KategoriProdukUsecaseEditKategoriProduk kategoriProdukUsecaseEdit;
  final KategoriProdukUsecaseDeleteKategoriProduk kategoriProdukUsecaseDelete;
  final KategoriProdukUsecaseGetAll kategoriProdukUsecaseGetAll;
  final KategoriProdukUsecaseGetById kategoriProdukUsecaseGetById;
  KategoriProdukBloc(
      {required this.kategoriProdukUsecaseAdd,
      required this.kategoriProdukUsecaseEdit,
      required this.kategoriProdukUsecaseDelete,
      required this.kategoriProdukUsecaseGetAll,
      required this.kategoriProdukUsecaseGetById})
      : super(KategoriProdukInitial()) {
    on<KategoriProdukEventAdd>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data = await kategoriProdukUsecaseAdd.execute(
          kategoriProduk: event.kategoriProdukModel);
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateSuccess());
        },
      );
    });
    on<KategoriProdukEventEdit>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data = await kategoriProdukUsecaseEdit.execute(
          kategoriProduk: event.kategoriProdukModel);
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateSuccess());
        },
      );
    });
    on<KategoriProdukEventDelete>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data = await kategoriProdukUsecaseDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateSuccess());
        },
      );
    });
    on<KategoriProdukEventGetAll>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data = await kategoriProdukUsecaseGetAll.execute();
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateLoadedAll(kategoriProduks: r));
        },
      );
    });
    on<KategoriProdukEventGetById>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data = await kategoriProdukUsecaseGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateLoaded(kategoriProduk: r));
        },
      );
    });
  }
}
