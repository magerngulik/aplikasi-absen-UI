import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QDialogError extends StatelessWidget {
  final String errorMessage;
  const QDialogError({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Center(
        child: Text(
          'Info',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Ok"),
        ),
        const SizedBox(
          height: 25.0,
        ),
      ],
    ).animate().shake().fadeIn();
  }
}

Future<dynamic> dialogError(BuildContext context, String errorMessage) {
  return showDialog(
    context: context,
    builder: (context) {
      return QDialogError(errorMessage: errorMessage);
    },
  );
}

Future<dynamic> dialogSuccess(BuildContext context, String errorMessage) {
  return showDialog(
    context: context,
    builder: (context) {
      return QDialogError(errorMessage: errorMessage);
    },
  );
}
