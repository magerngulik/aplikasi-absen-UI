part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.login({required String email, required String passwod}) = _Login;
  const factory AuthEvent.logout() = _Logout;
}