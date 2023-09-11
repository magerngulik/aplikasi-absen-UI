part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.login(
      {required String email, required String password}) = _Login;
  const factory AuthEvent.logout() = _Logout;
  const factory AuthEvent.register({
    required String username,
      required String email,
      required String password,
      required String address,
      required String birtdays,
      required String noTelp,
      }) = _Register;

}
