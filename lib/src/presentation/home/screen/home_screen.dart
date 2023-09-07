// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_attandance/src/presentation/auth/bloc/auth/auth_bloc.dart';
import 'package:new_attandance/src/presentation/auth/screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var auth = context.read<AuthBloc>();
    return BlocListener<AuthBloc, AuthState>(
      bloc: auth,
      listener: (context, state) {
        state.maybeMap(
          orElse: () {},
          unauthenticate: (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
          actions: [
            InkWell(
              onTap: () {
                auth.add(const AuthEvent.logout());
              },
              child: const Icon(
                Icons.logout,
                size: 24.0,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: const Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
