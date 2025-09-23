import 'package:daggerheart_beyond/presentation/blocs/auth/auth.dart';
import 'package:daggerheart_beyond/l10n/src/app_localizations.dart';
import 'package:daggerheart_beyond/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  var _userHasAccount = true;
  final _signUpFormKey = GlobalKey<FormState>();
  final _logInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_noEmailError;
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.auth_invalidEmailError;
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_noUsernameError;
    }
    if (value.length < 3) {
      return AppLocalizations.of(context)!.auth_shortUsernameError;
    }
    final usernameRegExp = RegExp(r'^[a-zA-Z0-9._]+$');
    if (!usernameRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.auth_wrongCharacterUsernameError;
    }
    if (value.contains(' ')) {
      return AppLocalizations.of(context)!.auth_spaceUsernameError;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_noPasswordError;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.auth_shortPasswordError;
    }
    return null;
  }

  void _onSignUpPressed(BuildContext context) {
    final isFormValid = _signUpFormKey.currentState?.validate() ?? false;
    final password = _passwordController.text;
    final passwordConfirm = _passwordConfirmController.text;
    final arePasswordsMatching = password == passwordConfirm;
    if (isFormValid && arePasswordsMatching) {
      context.read<AuthBloc>().add(
        CreateAccountPressed(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void _onLogInPressed(BuildContext context) {
    final isFormValid = _logInFormKey.currentState?.validate() ?? false;
    if (isFormValid) {
      context.read<AuthBloc>().add(
        LogInPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  Widget _buildSignUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              Spacings.verticalMd,
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.auth_email,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => _validateEmail(value),
              ),
              Spacings.verticalMd,
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.auth_username,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _validateUsername(value),
              ),
              Spacings.verticalMd,
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.auth_password,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _validatePassword(value),
              ),
              Spacings.verticalMd,
              TextFormField(
                controller: _passwordConfirmController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.auth_confirmPassword,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _validatePassword(value),
              ),
              Spacings.verticalMd,
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => _onSignUpPressed(context),
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(AppLocalizations.of(context)!.auth_signUp),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(AppLocalizations.of(context)!.auth_userHasAccount),
            TextButton(
              onPressed: () {
                setState(() {
                  _userHasAccount = !_userHasAccount;
                });
              },
              child: Text(AppLocalizations.of(context)!.auth_logIn),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogIn() {
    return Column(
      children: [
        Form(
          key: _logInFormKey,
          child: Column(
            children: [
              Spacings.verticalMd,
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.auth_email,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => _validateEmail(value),
              ),
              Spacings.verticalMd,
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.auth_password,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        Spacings.verticalMd,
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => _onLogInPressed(context),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(AppLocalizations.of(context)!.auth_logIn),
              ),
            );
          },
        ),
        Spacings.verticalMd,
        Row(
          children: [
            Text(AppLocalizations.of(context)!.auth_userHasNoAccount),
            TextButton(
              onPressed: () {
                setState(() {
                  _userHasAccount = !_userHasAccount;
                });
              },
              child: Text(AppLocalizations.of(context)!.auth_signUp),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedIn) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is AuthError) {
            final snackBar = SnackBar(
              content: Text(state.exception.toString()),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: Spacings.md, right: Spacings.md),
          child: _userHasAccount ? _buildLogIn() : _buildSignUp(),
        ),
      ),
    );
  }
}
