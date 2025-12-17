import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';
import '../../features/follow_up/data/repo/follow_up_repo.dart';
import '../../features/follow_up/data/datasources/follow_up_local_data_source.dart';
import '../../features/follow_up/data/datasources/follow_up_remote_data_source.dart';
import '../../features/follow_up/logic/follow_up_cubit.dart';
import '../../features/follow_up/logic/follow_up_details_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 1. Register async services (Dio, ApiService)
  await _registerAsyncServices();

  // 2. Register Feature Modules (Repos, Cubits)
  _registerFeatureModules();
}

/// Register Async Services like Dio and ApiService
Future<void> _registerAsyncServices() async {
  // Register Dio
  // Since DioFactory.getDio() is async, we can use registerSingletonAsync 
  // or just await it here if we want everything ready before app start.
  // The user's example used registerLazySingletonAsync but then awaited specific services.
  
  // Let's stick to the user's pattern but simplify since we have fewer services.
  
  // Register Dio
  getIt.registerLazySingletonAsync<Dio>(() => DioFactory.getDio());

  // Register ApiService (depends on Dio)
  getIt.registerLazySingletonAsync<ApiService>(
      () async => ApiService(await getIt.getAsync<Dio>()));
      
  // Wait for critical services to be ready
  await getIt.isReady<Dio>();
  await getIt.isReady<ApiService>();
}

/// Register Feature Modules (Repos and Cubits)
void _registerFeatureModules() {
  // Data Sources
  getIt.registerLazySingleton<FollowUpLocalDataSource>(() => FollowUpLocalDataSource());
  getIt.registerLazySingleton<FollowUpRemoteDataSource>(
      // We know ApiService is ready because we awaited it in setupGetIt
      () => FollowUpRemoteDataSource(getIt<ApiService>()));

  // Repository
  getIt.registerLazySingleton<FollowUpRepo>(() => FollowUpRepoImpl(getIt(), getIt()));

  // Cubit
  // FollowUpCubit expects a FollowUpRepo, which we just registered.
  getIt.registerFactory<FollowUpCubit>(() => FollowUpCubit(getIt()));
  getIt.registerFactory<FollowUpDetailsCubit>(() => FollowUpDetailsCubit(getIt()));
}
