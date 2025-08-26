part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignInPressed extends AuthEvent {
  final String email;
  final String password;

  SignInPressed({required this.email, required this.password});
}

class CreateAccountPressed extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String passwordConfirm;

  CreateAccountPressed({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  });
}