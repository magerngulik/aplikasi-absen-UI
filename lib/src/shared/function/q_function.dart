import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void customDebugPrint(Map<String, dynamic> variables) {
  variables.forEach((key, value) {
    debugPrint('$key: $value');
  });
}

SizedBox circularLoadingAuth(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

void getPermision() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
}
