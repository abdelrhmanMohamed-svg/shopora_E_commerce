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
