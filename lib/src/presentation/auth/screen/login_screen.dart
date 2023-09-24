// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_attandance/src/presentation/auth/screen/register_screen.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_button_access.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_button_auth.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_head_logo.dart';

import 'package:new_attandance/src/presentation/auth/widget/q_textfield_login.dart';
import 'package:new_attandance/src/presentation/home/screen/home_screen.dart';
import 'package:new_attandance/src/shared/bloc/theme/theme_cubit.dart';

import '../../../shared/function/q_function.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widget/q_dialog_error.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var auth = context.read<AuthBloc>();
    var theme = context.read<ThemeCubit>();

    return BlocListener<AuthBloc, AuthState>(
      bloc: auth,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          authenticate: (name, email, profile) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
          failed: (errorMessage) async {
            await showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return QDialogError(
                  errorMessage: errorMessage,
                );
              },
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<ThemeCubit, bool>(
              bloc: theme,
              builder: (context, state) {
                return IconButton(
                  icon: Icon(state ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    context.read<ThemeCubit>().changeTheme();
                  },
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                QHeadLogo(h: h, title: "Selamat Datang Kembali"),
                const SizedBox(
                  height: 30.0,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Lupa Password?",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  bloc: auth,
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return QButtonAuth(
                          h: h,
                          title: "Login",
                          onPress: () {
                            if (email.text.isEmpty && password.text.isEmpty) {
                              dialogError(context,
                                  "Email dan password tidak boleh kosong");
                            } else {
                              auth.add(AuthEvent.login(
                                  email: email.text, password: password.text));
                            }
                          },
                        );
                      },
                      loading: () {
                        return circularLoadingAuth(context);
                      },
                    );
                  },
                ),
                const Spacer(),
                QButtonAcccess(
                  title: "Belum punya akun?",
                  head: "Register",
                  onPress: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreens()),
                    );
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
