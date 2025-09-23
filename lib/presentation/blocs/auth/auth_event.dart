part of 'auth_bloc.dart';

sealed class AuthEvent {}

class LogInPressed extends AuthEvent {
  final String email;
  final String password;

  LogInPressed({required this.email, required this.password});
}

class CreateAccountPressed extends AuthEvent {
  final String username;
  final String email;
  final String password;

  CreateAccountPressed({
    required this.username,
    required this.email,
    required this.password,
  });
}
