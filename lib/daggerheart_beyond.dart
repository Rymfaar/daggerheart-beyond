import 'package:daggerheart_beyond/data/data_sources/firebase_auth_data_source.dart';
import 'package:daggerheart_beyond/data/repositories/auth_repository.dart';
import 'package:daggerheart_beyond/domain/repositories/auth_repository.dart';
import 'package:daggerheart_beyond/l10n/l10n.dart';
import 'package:daggerheart_beyond/l10n/src/app_localizations.dart';
import 'package:daggerheart_beyond/presentation/features/auth/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daggerheart_beyond/domain/blocs/auth/auth_bloc.dart';

class DaggerheartBeyondApp extends StatelessWidget {
  DaggerheartBeyondApp({super.key});

  final _authRespository = AuthRepository(FirebaseAuthDataSource());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daggerheart Beyond',
      debugShowCheckedModeBanner: true,
      // TODO: add custom theme
      supportedLocales: L10n.all,
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IAuthRepository>(create: (_) => _authRespository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(context.read<IAuthRepository>()),
            ),
          ],
          child: AuthView(),
        ),
      ),
    );
  }
}
