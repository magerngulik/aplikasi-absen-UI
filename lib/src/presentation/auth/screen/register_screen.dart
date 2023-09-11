// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_attandance/src/presentation/auth/screen/login_screen.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_button_access.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_button_auth.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_dialog_error.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_head_logo.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_textfield_login.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_time_picker.dart';
import 'package:new_attandance/src/shared/function/q_function.dart';

import '../bloc/auth/auth_bloc.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({Key? key}) : super(key: key);

  @override
  State<RegisterScreens> createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reapedPassword = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController notelp = TextEditingController();

  bool isNotEmpty(String text) {
    return text.trim().isNotEmpty;
  }

  bool isFormValid() {
    return isNotEmpty(email.text) &&
        isNotEmpty(password.text) &&
        isNotEmpty(username.text) &&
        isNotEmpty(address.text) &&
        isNotEmpty(birthday.text) &&
        isSame(password.text, reapedPassword.text) &&
        isNotEmpty(notelp.text);
  }

  bool isSame(String first, String second) {
    return first == second;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    // var w = MediaQuery.of(context).size.width;
    var auth = context.read<AuthBloc>();
    return BlocListener<AuthBloc, AuthState>(
      bloc: auth,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          failed: (errorMessage) {
            dialogError(context, errorMessage);
          },
          successRegister: () async {
            await dialogSuccess(context, "Berhasil Registratrasi");
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        );
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state.maybeWhen(loading: () {
              return circularLoadingAuth(context);
            }, orElse: () {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    QHeadLogo(h: h, title: "Register Akun"),
                    const SizedBox(
                      height: 30.0,
                    ),
                    QTextfieldAuth(
                      controller: username,
                      hint: "Masukan Username anda",
                      title: "Username",
                      isUseIcon: false,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QTextfieldAuth(
                      controller: email,
                      hint: "Masukan email anda",
                      title: "Email",
                      isUseIcon: false,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QTextfieldAuth(
                      controller: password,
                      hint: "Masukan password anda",
                      title: "Password",
                      isUseIcon: true,
                      icon: Icons.remove_red_eye,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QTextfieldAuth(
                      controller: reapedPassword,
                      hint: "Masukan ulang password anda",
                      title: "Repeat password",
                      isUseIcon: true,
                      icon: Icons.remove_red_eye,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QTextfieldAuth(
                      controller: address,
                      hint: "Masukan alamat anda",
                      title: "Alamat",
                      isUseIcon: false,
                      icon: Icons.remove_red_eye,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QDatePicker(
                      label: "Tanggal Lahir",
                      onChanged: (p0) {
                        birthday.text = p0.toString();
                      },
                      controller: birthday,
                    ),
                    QTextfieldAuth(
                      controller: notelp,
                      hint: "Masukan Nomor Telpon",
                      title: "Nomor Telpon",
                      isUseIcon: false,
                      icon: Icons.remove_red_eye,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    QButtonAuth(
                        h: h,
                        title: "Register",
                        onPress: () {
                          customDebugPrint({
                            'username': username.text,
                            'email': email.text,
                            'password': password.text,
                            'reapedPassword': reapedPassword.text,
                            'address': address.text,
                            'birdays': birthday.text,
                            'no telp': notelp.text,
                          });
                          if (isFormValid()) {
                            auth.add(AuthEvent.register(
                                username: username.text,
                                email: email.text,
                                password: password.text,
                                address: address.text,
                                birtdays: birthday.text,
                                noTelp: notelp.text));
                          } else {
                            dialogError(context,
                                "Semua data harus di masukan dan pastikan password nya sama");
                          }
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    QButtonAcccess(
                      title: "Sudah punya akun?",
                      head: "Login",
                      onPress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
