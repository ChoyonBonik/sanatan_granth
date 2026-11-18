import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'core/theme/bloc/theme_cubit.dart';
import 'core/theme/bloc/theme_state.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/contribute/presentation/bloc/contribute_bloc.dart';
import 'features/library/presentation/bloc/library_bloc.dart';
import 'features/offline/presentation/bloc/offline_bloc.dart';
import 'features/reader/presentation/bloc/structured_reader/structured_reader_bloc.dart';
import 'routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SupabaseClient? supabaseClient;
  try {
    if (AppConstants.supabaseUrl != 'https://placeholder-project.supabase.co') {
      // ignore: deprecated_member_use
      final Supabase supabase = await Supabase.initialize(
        url: AppConstants.supabaseUrl,
        // ignore: deprecated_member_use
        anonKey: AppConstants.supabaseAnonKey,
      );
      supabaseClient = supabase.client;
    }
  } catch (e) {
    debugPrint('Supabase initialization skipped or offline: $e');
  }

  // Initialize Clean Architecture Dependency Injection container
  await di.initDependencies(supabaseClient: supabaseClient);

  runApp(const SanatanLibraryApp());
}

class SanatanLibraryApp extends StatelessWidget {
  const SanatanLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemeCubit>(
          create: (_) => di.sl<ThemeCubit>(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()..add(CheckAuthStatusEvent()),
        ),
        BlocProvider<LibraryBloc>(
          create: (_) => di.sl<LibraryBloc>(),
        ),
        BlocProvider<StructuredReaderBloc>(
          create: (_) => di.sl<StructuredReaderBloc>(),
        ),
        BlocProvider<ContributeBloc>(
          create: (_) => di.sl<ContributeBloc>(),
        ),
        BlocProvider<OfflineBloc>(
          create: (_) => di.sl<OfflineBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          ThemeData activeTheme;
          switch (themeState.themeMode) {
            case AppThemeMode.sepia:
              activeTheme = AppTheme.sepiaTheme;
              break;
            case AppThemeMode.light:
              activeTheme = AppTheme.lightTheme;
              break;
            case AppThemeMode.amoledDark:
              activeTheme = AppTheme.amoledDarkTheme;
              break;
            case AppThemeMode.system:
              final Brightness platformBrightness =
                  MediaQuery.platformBrightnessOf(context);
              activeTheme = platformBrightness == Brightness.dark
                  ? AppTheme.amoledDarkTheme
                  : AppTheme.lightTheme;
              break;
          }

          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: activeTheme,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
