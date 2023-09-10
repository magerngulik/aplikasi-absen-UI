import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_attandance/my_app.dart';
import 'package:new_attandance/src/presentation/auth/bloc/auth/auth_bloc.dart';
import 'package:new_attandance/src/shared/bloc/theme/theme_cubit.dart';

import 'package:new_attandance/src/shared/services/bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
      BlocProvider(
        create: (context) => ThemeCubit(prefs: prefs),
      )
    ],
    child: const MyApp(),
  ));
}
