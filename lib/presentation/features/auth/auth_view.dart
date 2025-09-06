import 'package:daggerheart_beyond/domain/blocs/auth/auth.dart';
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
  final _formKey = GlobalKey<FormState>();
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_noPasswordError;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.auth_shortPasswordError;
    }
    return null;
  }

  void _onSignInPressed(BuildContext context) {
    print("SignIn button pressed");
    final isFormValid = _formKey.currentState?.validate() ?? false;
    print("Form valid: $isFormValid");
    final password = _passwordController.text;
    final passwordConfirm = _passwordConfirmController.text;
    final arePasswordsMatching = password == passwordConfirm;
    print("Passwords matching: $arePasswordsMatching");
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

  Widget _buildSignIn() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  onPressed: isLoading ? null : () => _onSignInPressed(context),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(AppLocalizations.of(context)!.auth_signIn),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //! UNSIGNED, Sign-in
    //* username field
    //* password confirm field
    //* sign in button
    //* go to sign in button
    //! UNSIGNED, Log-in
    //* username / email field
    //* password field
    //* sign in button
    //* go to sign ip button
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {},
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: Spacings.md, right: Spacings.md),
          child: _buildSignIn(),
        ),
      ),
    );
  }
}
