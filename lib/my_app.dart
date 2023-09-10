import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_attandance/src/presentation/auth/screen/login_screen.dart';
import 'package:new_attandance/src/shared/bloc/theme/theme_cubit.dart';
import 'package:new_attandance/src/shared/services/q_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<ThemeCubit>().cekTheme();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: state ? QTheme.isLight : QTheme.isDark,
          home: const LoginScreen(),
        );
      },
    );
  }
}
