import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/user_data_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

part 'auth_state.dart';

enum AuthFormat { login, register }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthService authService = AuthServiceImpl();
  final fireStoreService = FirestoreServices.instance;

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
    String username,
  ) async {
    emit(AuthLoading());
    try {
      final result = await authService.createUserWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        await _setUserData(email, username);
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
      fetchUser();
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
        final user = authService.getCuurentUser();
        if (user != null) {
          await _setUserData(user.email ?? '', user.displayName ?? 'New User');
        }
        emit(GoogleAuthSuccess());
      } else {
        emit(GoogleAuthError(message: "Failed to sign in"));
      }
    } catch (e) {
      emit(GoogleAuthError(message: e.toString()));
    }
  }

  Future<void> authenticateWithFacebook() async {
    emit(FacebookAuthLoading());
    try {
      final result = await authService.authenticateWithFacebook();
      if (result) {
        final user = authService.getCuurentUser();
        if (user != null) {
          await _setUserData(user.email ?? '', user.displayName ?? 'New User');
        }
        emit(FacebookAuthSuccess());
      } else {
        emit(FacebookAuthError(message: "Failed to sign in"));
      }
    } catch (e) {
      emit(FacebookAuthError(message: e.toString()));
    }
  }

  Future<void> _setUserData(String email, String username) async {
    final uid = authService.getCuurentUser()!.uid;
    final userdata = UserDataModel(
      uid: uid,
      email: email,
      username: username,
      createdDate: DateTime.now().toIso8601String(),
    );

    await fireStoreService.setData(
      path: ApiPaths.user(uid),
      data: userdata.toMap(),
    );
  }

  Future<void> fetchUser() async {
    emit(FecthUserLoading());
    try {
      final user = authService.getCuurentUser();
      if (user != null) {
        final userData = await authService.fetchUserData(user.uid);
        emit(AuthSuccess());
        emit(FetchUser(userData));
      } else {
        emit(FetchUserError("User not found"));
      }
    } catch (e) {
      emit(FetchUserError(e.toString()));
    }
  }
}
