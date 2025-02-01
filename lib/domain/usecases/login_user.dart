import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser({required this.repository});

  Future<String> execute(String email, String password) {
    return repository.login(email, password);
  }
}
