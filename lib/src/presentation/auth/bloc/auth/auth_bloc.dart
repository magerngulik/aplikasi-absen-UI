
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_attandance/src/presentation/auth/data/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const AuthState.loading());
      var services = AuthServices();
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var data =
          await services.doLogin(email: event.email, password: event.password);
      data.fold((l) {
        emit(AuthState.failed(errorMessage: l));
      }, (r) {
        var source = r['data'];
        var user = source['user'];
        var token = source['token'];
        String name = "";
        String email = "";
        String profile = "";

        name = user['name'];
        email = user['email'];
        profile = user['avatar'];
        prefs.setString('token', token);
        emit(
            AuthState.authenticate(name: name, email: email, profile: profile));
      });
    });

    on<_Register>((event, emit) async {
      emit(const AuthState.loading());
      var services = AuthServices();
      var data = await services.doRegister(
          name: event.username,
          email: event.email,
          password: event.password,
          tanggalLahir: event.birtdays,
          alamat: event.address,
          nomorTelp: event.noTelp);
      data.fold((l) {
        emit(AuthState.failed(errorMessage: l));
      }, (r) {
        emit(const AuthState.successRegister());
      });
    });

    on<_Logout>((event, emit) {
      emit(const AuthState.loading());
      Future.delayed(const Duration(seconds: 3));
      emit(const AuthState.unauthenticate());
    });
  }
}
