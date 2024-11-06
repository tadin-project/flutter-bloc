import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';
import 'core/usecase/usecase.dart';
import 'data/datasources/remote/role_remote_data_source.dart';
import 'data/datasources/remote/user_remote_data_source.dart';
import 'data/repositories/role_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/role_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/role/get_all_role_use_case/get_all_role_use_case.dart';
import 'domain/usecases/user/add_user/add_user_use_case.dart';
import 'domain/usecases/user/delete_user/delete_user_use_case.dart';
import 'domain/usecases/user/get_all/get_all_user_use_case.dart';
import 'domain/usecases/user/update_user/update_user_use_case.dart';
import 'presentation/bloc/user/form/role_bloc.dart';
import 'presentation/bloc/user/form/user_form_bloc.dart';
import 'presentation/bloc/user/main/user_bloc.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  //! Core
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => NoParams());

  //! Features - User
  // Bloc
  sl.registerFactory(
      () => UserBloc(getAllUserUseCase: sl(), deleteUserUseCase: sl()));
  sl.registerFactory(
      () => UserFormBloc(addUserUseCase: sl(), updateUserUseCase: sl()));
  sl.registerFactory(() => RoleBloc(getAllRoleUseCase: sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<RoleRepository>(
      () => RoleRepositoryImpl(remoteDataSource: sl()));
  // Usecase
  sl.registerLazySingleton(() => GetAllUserUseCase(sl()));
  sl.registerLazySingleton(() => GetAllRoleUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  // Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<RoleRemoteDataSource>(
      () => RoleRemoteDataSourceImpl(dio: sl()));

  //! External
}
