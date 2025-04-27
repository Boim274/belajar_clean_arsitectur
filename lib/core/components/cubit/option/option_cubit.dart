import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'option_state.dart';

class OptionCubit extends Cubit<bool> {
  OptionCubit() : super(true);
  void change() {
    emit(!state);
  }
}
