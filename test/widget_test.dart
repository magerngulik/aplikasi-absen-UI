// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:logger/logger.dart';
import 'package:new_attandance/src/presentation/auth/data/auth_service.dart';

void main() async {
  var log = Logger();
  var services = AuthServices();
  var data =
      await services.doLogin(email: "admin@admin.com", password: "password");

  data.fold((l) {
    log.e("gagal login = $l");
  }, (r) {
    log.d(r);
  });

  // var dataRegister = await services.doRegister(
  //     name: "Andi",
  //     email: "Andi1@gmail.com",
  //     password: "password",
  //     tanggalLahir: "2022-01-12",
  //     alamat: "Jalan Kutilang",
  //     nomorTelp: "08124554554");

  // dataRegister.fold((l) {
  //   log.e(l);
  //   debugPrint(l);
  // }, (r) {
  //   log.d(r);
  // });
}
