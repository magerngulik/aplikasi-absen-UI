import 'package:flutter/material.dart';

class QAlertFailed extends StatelessWidget {
  final String? head;
  final String title;
  final String? buttonTitle;
  const QAlertFailed({
    super.key,
    this.head,
    required this.title,
    this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Icon(
              Icons.warning_amber,
              size: 90.0,
              color: Colors.red,
            ),
            Text(
              head ?? "PERINGATAN",
              style: const TextStyle(
                fontSize: 24.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                buttonTitle ?? "Coba Lagi",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
