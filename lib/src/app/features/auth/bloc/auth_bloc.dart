import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignInWithFacebook>(_onSignInWithFacebook);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(seconds: 2));

    emit(Unauthenticated());
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(AuthMethod.google));
    try {
      // TRIGGER POINT: Add Google Sign-In logic here
      await Future.delayed(const Duration(seconds: 1)); // Simulation
      emit(Authenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignInWithFacebook(
    SignInWithFacebook event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(AuthMethod.facebook));
    try {
      // TRIGGER POINT: Add Facebook Sign-In logic here
      await Future.delayed(const Duration(seconds: 1)); // Simulation
      emit(Authenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
