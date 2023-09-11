import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
