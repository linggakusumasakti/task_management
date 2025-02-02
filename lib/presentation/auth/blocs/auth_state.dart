part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final Status status;
  final String? token;
  final String? error;

  const AuthState({required this.status, this.token, this.error});

  static AuthState initial() => const AuthState(status: Status.initial);

  AuthState copyWith({Status? status, String? token, String? error}) {
    return AuthState(
        status: status ?? this.status,
        token: token ?? this.token,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, token, error];
}
