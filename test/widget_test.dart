// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:new_attandance/src/presentation/auth/data/auth_service.dart';
import 'package:new_attandance/src/presentation/home/data/attandance_services.dart';

void main() async {
  final logger = Logger();
  Dio dio = Dio();
  group('Login Test', () {
    final authServices = AuthServices();
    final attandanceServices = AttandanceService(dioServices: dio);

    test('Login success test', () async {
      final data = await authServices.doLogin(
          email: "admin@admin.com", password: "password");

      data.fold(
        (l) {
          logger.e("gagal login = $l");
          fail('Login failed');
        },
        (r) {
          logger.d(r);
          expect(r, isNotNull);
        },
      );
    });

    test('Login failure test', () async {
      final data = await authServices.doLogin(
          email: "admin@admin.com", password: "password1");

      data.fold(
        (l) {
          logger.e("gagal login = $l");
          expect(l, isNotNull);
        },
        (r) {
          logger.d(r);
          fail('Login should fail');
        },
      );
    });

    test("Test Location true", () async {
      final data = await attandanceServices.cekLocation(
          latitude: "0.9978969",
          longitude: "102.7268471",
          token: "136|oeBvHm5lXlJrAK2w9l8G9gp4Mz1B2W47AcV44ytP");

      data.fold((l) {
        logger.e("error : $l");
        fail("hit api gagal");
      }, (r) {
        logger.d("data : $r");
        expect(r, {"message": "Jarak aman."});
      });
    });

    test("Test Current Get", () async {
      final data = await attandanceServices.getCurrent(
          token: "137|V5TGba9rhj2UiPyReaLpWL9BsxMOL2pO4OY3m8Ss");

      data.fold((l) {
        logger.e("error = $l");
        fail("Hit api gagal");
      }, (r) {
        var source = r;
        if (source['data'] == null) {
          expect(source['data'], null);
        } else {
          expect(source, isNotEmpty);
        }
        logger.d(r);
      });
    });
  });
}
