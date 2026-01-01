part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class SignInWithGoogle extends AuthEvent {}

class SignInWithFacebook extends AuthEvent {}

class SignOutRequested extends AuthEvent {}

class TokenRefreshed extends AuthEvent {
  final String token;
  const TokenRefreshed(this.token);

  @override
  List<Object> get props => [token];
}
