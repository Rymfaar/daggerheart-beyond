part of 'auth_bloc.dart';

// TODO: Cubit?
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

//* Initial state
class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final Exception exception;

  AuthError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class AuthLoggedIn extends AuthState {
  final UserEntity user;

  AuthLoggedIn(this.user);

  @override
  List<Object?> get props => [user];
}
