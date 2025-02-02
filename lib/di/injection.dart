import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/core/data/datasources/local_data_source.dart';
import 'package:task_management/core/data/datasources/remote_data_source.dart';
import 'package:task_management/core/data/db/database_provider.dart';
import 'package:task_management/core/data/repositories/auth_repository_impl.dart';
import 'package:task_management/core/data/repositories/task_repository_impl.dart';
import 'package:task_management/domain/repositories/auth_repository.dart';
import 'package:task_management/domain/repositories/task_repository.dart';
import 'package:task_management/domain/usecases/add_task.dart';
import 'package:task_management/domain/usecases/get_tasks.dart';
import 'package:task_management/domain/usecases/login_user.dart';
import 'package:task_management/presentation/auth/blocs/auth_bloc.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';

import '../presentation/add_task/blocs/add_task_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory<AuthBloc>(() => AuthBloc(loginUser: locator()));
  locator.registerFactory<TaskBloc>(() => TaskBloc(addTask: locator(), getTasks: locator()));
  locator.registerFactory<AddTaskBloc>(() => AddTaskBloc(addTask: locator()));

  // use cases
  locator.registerLazySingleton(() => LoginUser(repository: locator()));
  locator.registerLazySingleton(() => AddTask(repository: locator()));
  locator.registerLazySingleton(() => GetTasks(repository: locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: http.Client()));
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(provider: DatabaseProvider()));
}
