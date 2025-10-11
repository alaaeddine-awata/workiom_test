import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';
import '../../data/services/api_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/edition_repository.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/edition/edition_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  getIt.registerLazySingleton<DioClient>(() => DioClient.instance);
  
  // Services
  getIt.registerLazySingleton<ApiService>(() => ApiServiceProvider.instance);
  
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      apiService: getIt<ApiService>(),
      dioClient: getIt<DioClient>(),
    ),
  );
  
  getIt.registerLazySingleton<EditionRepository>(
    () => EditionRepository(apiService: getIt<ApiService>()),
  );
  
  // BLoCs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<EditionBloc>(
    () => EditionBloc(editionRepository: getIt<EditionRepository>()),
  );
}
