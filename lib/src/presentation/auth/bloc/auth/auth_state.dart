part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.failed({required String errorMessage}) = _Failed;
  const factory AuthState.authenticate(
      {required String name,
      required String email,
      required String profile}) = _Authenticate;
  const factory AuthState.unauthenticate() = _Unauthenticate;
  const factory AuthState.successRegister() = _SuccessRegister;
}
