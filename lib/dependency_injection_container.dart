import 'package:counter_demo_bloc/feature/auth/data/data_sources/auth_data_source.dart';
import 'package:counter_demo_bloc/feature/auth/data/repositories/auth_repository.dart';
import 'package:counter_demo_bloc/feature/auth/domain/repositories/auth_repository.dart';
import 'package:counter_demo_bloc/feature/auth/domain/usecases/login_with_otp_usecase.dart';
import 'package:counter_demo_bloc/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:counter_demo_bloc/feature/counter/presentation/bloc/counter_bloc.dart';
import 'package:counter_demo_bloc/helper/session_manager.dart';
import 'package:counter_demo_bloc/network/api_client.dart';
import 'package:counter_demo_bloc/network/api_client_imp.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);

  serviceLocator.registerLazySingleton<SessionManager>(
    () => SessionManagerImp(sharedPreferences: sharedPreferences),
  );
  serviceLocator.registerLazySingleton<ApiClient>(
    () => ApiClientImp(sessionManager: serviceLocator()),
  );
  initCounter();
  _initAuth();
}

initCounter() {
  serviceLocator.registerLazySingleton(() => CounterBloc());
}

void _initAuth() {
  serviceLocator
    // Register AuthDataSource
    ..registerFactory<AuthDataSource>(
      () => AuthDataSourceImp(
        apiClient: serviceLocator(),
        sessionManager: serviceLocator(),
      ),
    )
    // Register AuthRepository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImp(authDataSource: serviceLocator()),
    )
    //  Register LoginWithMobileUseCase before AuthBloc
    ..registerFactory(
      () => LoginWithMobileUseCase(authRepository: serviceLocator()),
    )
    // Register AuthBloc
    ..registerFactory(() => AuthBloc(loginWithMobileUseCase: serviceLocator()));
}
