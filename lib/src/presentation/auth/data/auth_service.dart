import 'package:dartz/dartz.dart';

import '../../../shared/util/q_export.dart';

class AuthServices {
  Future<Either<String, Map<String, dynamic>>> doLogin(
      {required String email, required String password}) async {
    String baseUrl = baseUrlX;
    debugPrint("email => $email");
    debugPrint("password => $password");
    try {
      var response = await Dio().post(
        "$baseUrl/api/auth/login",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "email": email,
          "password": password,
        },
      );
      Map<String, dynamic> obj = response.data;
      debugPrint(obj.toString());
      return Right(obj);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          return Left(e.response!.data['message']);
        }
        debugPrint(e.response!.statusMessage);
        debugPrint(e.response!.data);
      }

      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> doRegister({
    required String name,
    required String email,
    required String password,
    required String tanggalLahir,
    required String alamat,
    required String nomorTelp,
  }) async {
    try {
      var response = await Dio().post(
        "http://attendance-app.test/api/auth/register",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "name": name,
          "email": email,
          "password": password,
          "tanggal_lahir": tanggalLahir,
          "alamat": alamat,
          "nomor_telp": nomorTelp,
        },
      );
      Map<String, dynamic> obj = response.data;
      return Right(obj);
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        final errorMessages = [];

        e.response!.data["errors"].forEach((field, errors) {
          final errorMessage = "$field: ${errors.join(', ')}";
          errorMessages.add(errorMessage);
        });
        final errorString = errorMessages.join('\n');
        return Left(errorString);
      }
      return Left(e.toString());
    }
  }
}
