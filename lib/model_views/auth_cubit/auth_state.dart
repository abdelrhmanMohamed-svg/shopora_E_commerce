part of 'auth_cubit.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class ToggleAuth extends AuthState {
  final AuthFormat authFormat;

  const ToggleAuth({required this.authFormat});
}

final class ToggleVisibilty extends AuthState {
  final bool isVisible;

  const ToggleVisibilty({required this.isVisible});
}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});
}

final class SignOutLoading extends AuthState {}

final class SiginOutSuccess extends AuthState {}

final class SignOutError extends AuthState {
  final String message;

  const SignOutError({required this.message});
}

final class GoogleAuthLoading extends AuthState {}

final class GoogleAuthSuccess extends AuthState {}

final class GoogleAuthError extends AuthState {
  final String message;

  const GoogleAuthError({required this.message});
}

final class FacebookAuthLoading extends AuthState {}

final class FacebookAuthSuccess extends AuthState {}

final class FacebookAuthError extends AuthState {
  final String message;

  const FacebookAuthError({required this.message});
}

final class FecthUserLoading extends AuthState {}

final class FetchUser extends AuthState {
  final UserDataModel userData;

  const FetchUser(this.userData);
}

final class FetchUserError extends AuthState {
  final String error;

  const FetchUserError(this.error);
}
