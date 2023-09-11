import 'package:flutter/material.dart';

class QDialogError extends StatelessWidget {
  final String errorMessage;
  const QDialogError({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Info'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(errorMessage),
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
      ],
    );
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
