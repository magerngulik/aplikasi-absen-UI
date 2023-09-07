import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:new_attandance/my_app.dart';
import 'package:new_attandance/src/shared/services/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}
