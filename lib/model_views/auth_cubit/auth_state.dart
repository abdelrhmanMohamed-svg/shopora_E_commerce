part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class ToggleAuth extends AuthState {
  final AuthFormat authFormat;

  ToggleAuth({required this.authFormat});
}

final class ToggleVisibilty extends AuthState {
  final bool isVisible;

  ToggleVisibilty({required this.isVisible});
}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

final class SignOutLoading extends AuthState {}

final class SiginOutSuccess extends AuthState {}

final class SignOutError extends AuthState {
  final String message;

  SignOutError({required this.message});
}

final class GoogleAuthLoading extends AuthState {}

final class GoogleAuthSuccess extends AuthState {}

final class GoogleAuthError extends AuthState {
  final String message;

  GoogleAuthError({required this.message});
}

final class FacebookAuthLoading extends AuthState {}

final class FacebookAuthSuccess extends AuthState {}

final class FacebookAuthError extends AuthState {
  final String message;

  FacebookAuthError({required this.message});
}
