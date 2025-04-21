
import 'package:belajar_clean_arsitectur/features/Auth/domain/entities/users.dart';
import 'package:belajar_clean_arsitectur/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInWithEmail;

  AuthBloc({required this.signInWithEmail}) : super(AuthStateInitial()) {
    on<authEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      // proses database
      final data = await signInWithEmail(
          SignInWithEmailParams(email: event.email, password: event.password));
      data.fold((left) {
        emit(AuthStateError(left.toString()));
      },(right) {
        emit(AuthStateLoaded(right));
      });
    });
  }
}
