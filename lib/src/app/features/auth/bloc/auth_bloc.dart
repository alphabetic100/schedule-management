import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_management/src/core/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<String?>? _tokenSubscription;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignInWithFacebook>(_onSignInWithFacebook);
    on<SignOutRequested>(_onSignOutRequested);
    on<TokenRefreshed>(_onTokenRefreshed);

    _tokenSubscription = _authRepository.idTokenStream.listen((token) {
      if (token != null) {
        add(TokenRefreshed(token));
      }
    });
  }

  @override
  Future<void> close() {
    _tokenSubscription?.cancel();
    return super.close();
  }

  Future<void> _onTokenRefreshed(
    TokenRefreshed event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint("ID Token refreshed: ${event.token}");
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    final user = await _authRepository.getCurrentUser();

    if (user != null) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(AuthMethod.google));
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
      log(e.toString());
    }
  }

  Future<void> _onSignInWithFacebook(
    SignInWithFacebook event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(AuthMethod.facebook));
    try {
      final user = await _authRepository.signInWithFacebook();
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
      log(e.toString());
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
    emit(Unauthenticated());
  }
}
