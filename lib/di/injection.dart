import 'package:get_it/get_it.dart';
import 'package:task_management/core/data/datasources/remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/core/data/repositories/auth_repository_impl.dart';
import 'package:task_management/domain/repositories/auth_repository.dart';
import 'package:task_management/domain/usecases/login_user.dart';
import 'package:task_management/presentation/auth/blocs/auth_bloc.dart';

final locator = GetIt.instance;

void init() {

  // bloc
  locator.registerFactory<AuthBloc>(() => AuthBloc(loginUser: locator()));

  // use cases
  locator.registerLazySingleton(() => LoginUser(repository: locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: locator()));

  // data sources
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: http.Client()));
}
