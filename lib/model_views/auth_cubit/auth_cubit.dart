import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

enum AuthFormat { login, register }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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
}
