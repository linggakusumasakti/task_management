import 'package:task_management/core/data/datasources/remote_data_source.dart';

import '../../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> login(String email, String password) async {
    final data = await remoteDataSource.login(email, password);
    return data;
  }
}