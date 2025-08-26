import 'package:daggerheart_beyond/domain/blocs/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.exception.toString())),
            );
          }
          if (state is AuthSignedIn) {
            // Navigate to home or main screen
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (email) {
                  // Store email in local variable or form state
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (password) {
                  // Store password in local variable or form state
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            // Dispatch sign in event to AuthBloc
                            context.read<AuthBloc>().add(
                                  SignInPressed(
                                    email: 'email',
                                    password: 'password',
                                  ),
                                );
                          },
                    child: state is AuthLoading
                        ? const CircularProgressIndicator()
                        : const Text('Sign In'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}