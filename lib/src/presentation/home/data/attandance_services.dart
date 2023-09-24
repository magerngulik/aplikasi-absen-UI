// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_attandance/src/shared/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttandanceService {
  Dio dioServices;
  AttandanceService({
    required this.dioServices,
  });

  String baseUrl = "$baseUrlX/api/attendance";

  Future<Either<String, Map<String, dynamic>>> cekLocation(
      {required String latitude,
      required String longitude,
      String? token}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? dataToken = prefs.getString('token');
      var response = await dioServices.get("$baseUrl/location",
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $dataToken"
            },
          ),
          queryParameters: {
            "latitude": latitude,
            "longitude": longitude,
          });
      Map<String, dynamic> obj = response.data;
      debugPrint(obj.toString());
      return Right(obj);
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> getCurrent(
      {String? token}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataToken = prefs.getString('token');
    debugPrint("token => $dataToken");
    debugPrint("url => $baseUrl");
    try {
      var response = await dioServices.get("$baseUrl/current",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $dataToken"
          }));
      Map<String, dynamic> obj = response.data;
      return Right(obj);
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
