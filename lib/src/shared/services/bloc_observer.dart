import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyBlocObserver extends BlocObserver {
  Logger log = Logger();
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.d(change);
  }
}
