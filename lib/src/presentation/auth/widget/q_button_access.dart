import 'package:flutter/material.dart';

class QButtonAcccess extends StatelessWidget {
  final String title;
  final String head;
  final Function onPress;
  const QButtonAcccess({
    Key? key,
    required this.title,
    required this.head,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            head,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.green,
            ),
          ),
        )
      ],
    );
  }
}
