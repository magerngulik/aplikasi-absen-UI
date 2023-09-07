// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_attandance/src/presentation/auth/widget/q_textfield_login.dart';
import 'package:new_attandance/src/presentation/home/screen/home_screen.dart';

import '../bloc/auth/auth_bloc.dart';

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
    // var w = MediaQuery.of(context).size.width;
    var auth = context.read<AuthBloc>();

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
                return AlertDialog(
                  title: const Text('Info'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(errorMessage),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Scaffold(
          body: Container(
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
                        debugPrint("email =>${email.text}");
                        debugPrint("password =>${password.text}");
                        auth.add(AuthEvent.login(
                            email: email.text, password: password.text));
                      },
                    );
                  },
                  loading: () {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                );
              },
            ),
            const Spacer(),
            QButtonAcccess(
              title: "Belum punya akun?",
              head: "Register",
              onPress: () {},
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      )),
    );
  }
}

class QButtonAcccess extends StatelessWidget {
  final String title;
  final String head;
  final Function onPress;
  const QButtonAcccess({
    Key? key,
    required this.title,
    required this.head,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            head,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.green,
            ),
          ),
        )
      ],
    );
  }
}

class QButtonAuth extends StatelessWidget {
  final String title;
  final double h;
  final Function onPress;
  const QButtonAuth({
    super.key,
    required this.h,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: h * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        onPressed: () => onPress(),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class QHeadLogo extends StatelessWidget {
  final String title;
  const QHeadLogo({
    Key? key,
    required this.title,
    required this.h,
  }) : super(key: key);

  final double h;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: h / 8,
              width: h / 8,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/icon/logo.png",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ke ",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Aplikasi Absen Guru",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
