import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/domain/usecases/login_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;

  AuthBloc({required this.loginUser}) : super(AuthState.initial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: AuthStatus.loading));
        final login = await loginUser.execute(event.email, event.password);
        emit(state.copyWith(status: AuthStatus.success, token: login));
      } on FormatException catch (e) {
        emit(state.copyWith(status: AuthStatus.error, error: e.message));
      }
    });
  }
}
