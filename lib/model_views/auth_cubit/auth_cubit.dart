import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';

part 'auth_state.dart';

enum AuthFormat { login, register }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthService authService = AuthServiceImpl();

  void toggleAuth(AuthFormat authFormat) {
    emit(
      ToggleAuth(
        authFormat: authFormat == AuthFormat.login
            ? AuthFormat.register
            : AuthFormat.login,
      ),
    );
  }

  void toggleVisibilty(bool isVisible) {
    emit(ToggleVisibilty(isVisible: !isVisible));
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await authService.signInWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthError(message: "Failed to sign in"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(AuthLoading());
    try {
      final result = await authService.createUserWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthError(message: "Failed to create account"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void authCheck() {
    final user = authService.getCuurentUser();
    if (user != null) {
      emit(AuthSuccess());
    }
  }

  void signOut() async {
    emit(SignOutLoading());
    try {
      await authService.signOut();
      emit(SiginOutSuccess());
    } catch (e) {
      emit(SignOutError(message: e.toString()));
    }
  }

  Future<void> authenticateWithGoogle() async {
    emit(GoogleAuthLoading());
    try {
      final result = await authService.authenticateWithGoogle();
      if (result) {
        emit(GoogleAuthSuccess());
      } else {
        emit(GoogleAuthError(message: "Failed to sign in"));
      }
    } catch (e) {
      emit(GoogleAuthError(message: e.toString()));
    }
  }
}
