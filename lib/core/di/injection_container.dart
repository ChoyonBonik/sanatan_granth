import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Core
import '../network/network_info.dart';
import '../theme/bloc/theme_cubit.dart';

// Offline & Database
import '../../features/offline/data/database/app_database.dart';
import '../../features/offline/data/datasources/offline_local_data_source.dart';
import '../../features/offline/data/repositories/offline_repository_impl.dart';
import '../../features/offline/domain/repositories/offline_repository.dart';
import '../../features/offline/presentation/bloc/offline_bloc.dart';

// Auth
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

// Library
import '../../features/library/data/datasources/library_remote_data_source.dart';
import '../../features/library/data/repositories/library_repository_impl.dart';
import '../../features/library/domain/repositories/library_repository.dart';
import '../../features/library/domain/usecases/get_books_usecase.dart';
import '../../features/library/domain/usecases/get_categories_usecase.dart';
import '../../features/library/domain/usecases/get_book_details_usecase.dart';
import '../../features/library/domain/usecases/search_books_usecase.dart';
import '../../features/library/presentation/bloc/library_bloc.dart';

// Reader
import '../../features/reader/data/datasources/reader_remote_data_source.dart';
import '../../features/reader/data/repositories/reader_repository_impl.dart';
import '../../features/reader/domain/repositories/reader_repository.dart';
import '../../features/reader/domain/usecases/get_structured_verses_usecase.dart';
import '../../features/reader/presentation/bloc/structured_reader/structured_reader_bloc.dart';
import '../../features/reader/services/audio_handler.dart';
import '../../features/reader/services/tts_service.dart';

// Contribute
import '../../features/contribute/data/datasources/contribute_remote_data_source.dart';
import '../../features/contribute/data/repositories/contribute_repository_impl.dart';
import '../../features/contribute/domain/repositories/contribute_repository.dart';
import '../../features/contribute/domain/usecases/submit_contribution_usecase.dart';
import '../../features/contribute/presentation/bloc/contribute_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies({SupabaseClient? supabaseClient}) async {
  // ---------------------------------------------------------------------------
  // External & Core Singletons
  // ---------------------------------------------------------------------------
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl<Connectivity>()),
  );

  // Local Drift SQLite Database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Theme Cubit
  sl.registerFactory<ThemeCubit>(
    () => ThemeCubit(prefs: sl<SharedPreferences>()),
  );

  // ---------------------------------------------------------------------------
  // Reader Services (TTS & Audio Player)
  // ---------------------------------------------------------------------------
  final TtsService ttsService = TtsService();
  await ttsService.initialize();
  sl.registerLazySingleton<TtsService>(() => ttsService);
  sl.registerLazySingleton<SanatanAudioHandler>(() => SanatanAudioHandler());

  // ---------------------------------------------------------------------------
  // Feature: Auth
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: supabaseClient),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );
  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInUseCase: sl<SignInUseCase>(),
      signUpUseCase: sl<SignUpUseCase>(),
      signOutUseCase: sl<SignOutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
    ),
  );

  // ---------------------------------------------------------------------------
  // Feature: Library
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSourceImpl(supabaseClient: supabaseClient),
  );
  sl.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(remoteDataSource: sl<LibraryRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl<LibraryRepository>()),
  );
  sl.registerLazySingleton<GetBooksUseCase>(
    () => GetBooksUseCase(sl<LibraryRepository>()),
  );
  sl.registerLazySingleton<SearchBooksUseCase>(
    () => SearchBooksUseCase(sl<LibraryRepository>()),
  );
  sl.registerLazySingleton<GetBookDetailsUseCase>(
    () => GetBookDetailsUseCase(sl<LibraryRepository>()),
  );
  sl.registerFactory<LibraryBloc>(
    () => LibraryBloc(
      getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      getBooksUseCase: sl<GetBooksUseCase>(),
      searchBooksUseCase: sl<SearchBooksUseCase>(),
      getBookDetailsUseCase: sl<GetBookDetailsUseCase>(),
    ),
  );

  // ---------------------------------------------------------------------------
  // Feature: Reader
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<ReaderRemoteDataSource>(
    () => ReaderRemoteDataSourceImpl(supabaseClient: supabaseClient),
  );
  sl.registerLazySingleton<ReaderRepository>(
    () => ReaderRepositoryImpl(remoteDataSource: sl<ReaderRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetStructuredVersesUseCase>(
    () => GetStructuredVersesUseCase(sl<ReaderRepository>()),
  );
  sl.registerFactory<StructuredReaderBloc>(
    () => StructuredReaderBloc(
      getStructuredVersesUseCase: sl<GetStructuredVersesUseCase>(),
      ttsService: sl<TtsService>(),
    ),
  );

  // ---------------------------------------------------------------------------
  // Feature: Contribute
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<ContributeRemoteDataSource>(
    () => ContributeRemoteDataSourceImpl(supabaseClient: supabaseClient),
  );
  sl.registerLazySingleton<ContributeRepository>(
    () => ContributeRepositoryImpl(
      remoteDataSource: sl<ContributeRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<SubmitContributionUseCase>(
    () => SubmitContributionUseCase(sl<ContributeRepository>()),
  );
  sl.registerFactory<ContributeBloc>(
    () => ContributeBloc(
      submitUseCase: sl<SubmitContributionUseCase>(),
      repository: sl<ContributeRepository>(),
    ),
  );

  // ---------------------------------------------------------------------------
  // Feature: Offline
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<OfflineLocalDataSource>(
    () => OfflineLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<OfflineRepository>(
    () => OfflineRepositoryImpl(localDataSource: sl<OfflineLocalDataSource>()),
  );
  sl.registerFactory<OfflineBloc>(
    () => OfflineBloc(repository: sl<OfflineRepository>()),
  );
}
