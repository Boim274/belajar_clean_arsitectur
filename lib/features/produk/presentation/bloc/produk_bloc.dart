import 'package:belajar_clean_arsitectur/features/produk/data/models/produk_model.dart';
import 'package:belajar_clean_arsitectur/features/produk/domain/entities/produk.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  ProdukBloc() : super(ProdukInitial()) {
    on<ProdukEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
