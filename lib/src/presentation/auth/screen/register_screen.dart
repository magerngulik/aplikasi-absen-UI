// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:new_attandance/src/presentation/auth/screen/login_screen.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_textfield_login.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({Key? key}) : super(key: key);

  @override
  State<RegisterScreens> createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            QHeadLogo(h: h, title: "Register Akun"),
            const SizedBox(
              height: 30.0,
            ),
            QTextfieldAuth(
              controller: email,
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
              controller: email,
              hint: "Masukan password anda",
              title: "Password",
              isUseIcon: true,
              icon: Icons.remove_red_eye,
            ),
            const SizedBox(
              height: 10.0,
            ),
            QTextfieldAuth(
              controller: email,
              hint: "Masukan ulang password anda",
              title: "Password",
              isUseIcon: true,
              icon: Icons.remove_red_eye,
            ),
            const SizedBox(
              height: 10.0,
            ),
            QTextfieldAuth(
              controller: email,
              hint: "Masukan alamat anda",
              title: "Alamat",
              isUseIcon: false,
              icon: Icons.remove_red_eye,
            ),
            const SizedBox(
              height: 20.0,
            ),
            QButtonAuth(h: h, title: "Register", onPress: () {}),
            const Spacer(),
            QButtonAcccess(
              title: "Sudah punya akun?",
              head: "Login",
              onPress: () {},
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
