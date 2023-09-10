import 'package:flutter/material.dart';

class QButtonAuth extends StatelessWidget {
  final String title;
  final double h;
  final Function onPress;
  const QButtonAuth({
    super.key,
    required this.h,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: h * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        onPressed: () => onPress(),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
