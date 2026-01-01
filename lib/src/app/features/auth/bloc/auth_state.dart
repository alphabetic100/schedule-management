part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

enum AuthMethod { google, facebook }

class AuthLoading extends AuthState {
  final AuthMethod? method;
  const AuthLoading([this.method]);

  @override
  List<Object> get props => [if (method != null) method!];
}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
