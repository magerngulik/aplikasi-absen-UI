part of 'user_status_cubit.dart';

@freezed
class UserStatusState with _$UserStatusState {
  const factory UserStatusState.initial() = _Initial;
  const factory UserStatusState.loading() =
      _Loading;
  const factory UserStatusState.failed({required String errorMessage}) = _Failed;
  const factory UserStatusState.signIn() =
      _Signin;
  const factory UserStatusState.signOut({required Map<String, dynamic> data}) =
      _Signout;
  const factory UserStatusState.complate({required Map<String, dynamic> data}) =
      _Complate;
}
