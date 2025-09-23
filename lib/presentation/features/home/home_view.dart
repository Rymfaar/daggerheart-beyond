import 'package:daggerheart_beyond/l10n/src/app_localizations.dart';
import 'package:daggerheart_beyond/presentation/blocs/home/home_bloc.dart';
import 'package:daggerheart_beyond/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _onSignOutPressed(BuildContext context) {
    context.read<HomeBloc>().add(LogOutPressed());
  }

  Widget _buildHome(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.home,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () => _onSignOutPressed(context),
            child: Text(AppLocalizations.of(context)!.auth_logOut),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.home_title)),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoggedOut) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (state is HomeError) {
            final snackBar = SnackBar(
              content: Text(state.exception.toString()),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: Spacings.md, right: Spacings.md),
          child: _buildHome(context),
        ),
      ),
    );
  }
}
