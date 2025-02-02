import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser({required this.repository});

  Future<String> execute(String email, String password) =>
      repository.login(email, password);
}
