
part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnnonKey);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  serviceLocator.registerFactory(() => InternetConnection());
  // core
  serviceLocator.registerLazySingleton(
        () => AppUserCubit(),
  );

  serviceLocator.registerFactory<ConnectionChecker>(
          () => ConnectionCheckerImpl(serviceLocator()));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(serviceLocator()));
  serviceLocator.registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AuthBloc(
    userSignUp: serviceLocator(),
    userLogin: serviceLocator(),
    currentUser: serviceLocator(),
    appUserCubit: serviceLocator(),
  ));
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
            () => BlogRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<BlogLocalDataSource>(
            () => BlogLocalDataSourceImpl(serviceLocator()))
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerLazySingleton(() => BlogBloc(
      uploadBlog: serviceLocator(),
      getAllBlogs: serviceLocator(),
    ));
}
