import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  final SharedPreferences prefs;

  ThemeCubit({required this.prefs}) : super(true);

  changeTheme() async {
    await prefs.setBool("theme", !state);
    emit(!state);
  }

  cekTheme() async {
    bool? data = prefs.getBool("theme") ?? false;
    emit(data);
  }
}
