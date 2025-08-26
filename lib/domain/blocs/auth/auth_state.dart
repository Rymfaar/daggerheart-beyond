part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthSignedOut extends AuthState {}

class AuthError extends AuthState {
  final Exception exception;

  AuthError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class AuthLoading extends AuthState {}

class AuthSignedIn extends AuthState {
  final UserEntity user;

  AuthSignedIn(this.user);

  @override
  List<Object?> get props => [user];
}
