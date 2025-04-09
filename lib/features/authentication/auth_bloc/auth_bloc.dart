import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../data/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
    on<LogoutEvent>(_onLogout);
    on<SignInWithGoogleRequested>(_onSignInWithGoogle);
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithEmail(event.email, event.password);
      emit(AuthSuccess(user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUpWithEmail(event.email, event.password);
      emit(AuthSuccess(user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(AuthInitial());
  }

  void _onSignInWithGoogle(SignInWithGoogleRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithGoogle();
      emit(AuthSuccess(user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}