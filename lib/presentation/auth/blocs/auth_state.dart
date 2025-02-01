part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? token;
  final String? error;

  const AuthState({required this.status, this.token, this.error});

  static AuthState initial() => const AuthState(status: AuthStatus.initial);

  AuthState copyWith({AuthStatus? status, String? token, String? error}) {
    return AuthState(
        status: status ?? this.status,
        token: token ?? this.token,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, token, error];
}
