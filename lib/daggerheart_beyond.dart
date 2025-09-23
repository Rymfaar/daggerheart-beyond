import 'package:daggerheart_beyond/data/data_sources/firebase_auth_data_source.dart';
import 'package:daggerheart_beyond/data/data_sources/firebase_firestore_data_source.dart';
import 'package:daggerheart_beyond/data/repositories/auth_repository.dart';
import 'package:daggerheart_beyond/data/repositories/user_repository.dart';
import 'package:daggerheart_beyond/domain/repositories/auth_repository.dart';
import 'package:daggerheart_beyond/domain/repositories/user_repository.dart';
import 'package:daggerheart_beyond/domain/use_case/auth_use_case.dart';
import 'package:daggerheart_beyond/l10n/l10n.dart';
import 'package:daggerheart_beyond/l10n/src/app_localizations.dart';
import 'package:daggerheart_beyond/presentation/features/auth/auth_view.dart';
import 'package:daggerheart_beyond/presentation/features/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daggerheart_beyond/presentation/blocs/auth/auth.dart';
import 'package:daggerheart_beyond/presentation/blocs/home/home.dart';

class DaggerheartBeyondApp extends StatelessWidget {
  const DaggerheartBeyondApp({super.key});

  List<RepositoryProvider> _createRepositories() {
    return [
      RepositoryProvider<IAuthRepository>(
        create: (_) => AuthRepository(FirebaseAuthDataSource()),
      ),
      RepositoryProvider<IUserRepository>(
        create: (_) => UserRepository(FirebaseFirestoreDataSource()),
      ),
    ];
  }

  List<BlocProvider> _createBlocs() {
    return [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          AuthUseCase(
            context.read<IUserRepository>(),
            context.read<IAuthRepository>(),
          ),
        ),
      ),
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(
          AuthUseCase(
            context.read<IUserRepository>(),
            context.read<IAuthRepository>(),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _createRepositories(),
      child: MultiBlocProvider(
        providers: _createBlocs(),
        child: MaterialApp(
          title: 'Daggerheart Beyond',
          debugShowCheckedModeBanner: true,
          // TODO: add custom theme
          supportedLocales: L10n.all,
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routes: {
            '/': (context) => const AuthView(),
            '/home': (context) => const HomeView(),
          },
          initialRoute: '/',
        ),
      ),
    );
  }
}
