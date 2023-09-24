// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:new_attandance/src/presentation/home/data/attandance_services.dart';

part 'location_cubit.freezed.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  Dio dioService;
  LocationCubit(
    this.dioService,
  ) : super(const LocationState.initial());

  void checkLocation(
      {required double latitude, required double longitude}) async {
    emit(const _Loading());
    debugPrint("latitude: $latitude /n longitude: $longitude");

    var services = AttandanceService(dioServices: dioService);
    var data = await services.cekLocation(
        latitude: latitude.toString(), longitude: longitude.toString());
    data.fold((l) {
      emit(const LocationState.failed());
    }, (r) {
      if (r['message'] == null) {
        emit(const LocationState.outLocation());
      } else {
        emit(const LocationState.inLocation());
      }
    });
  }
}
