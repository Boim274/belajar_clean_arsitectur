import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_state_state.dart';

class FavoriteStateCubit extends Cubit<bool> {
  FavoriteStateCubit()
      : super(false); // Status default adalah belum favorit (false)

  void toggleFavorite() {
    emit(!state); // Mengubah status favorit menjadi sebaliknya
  }
}
