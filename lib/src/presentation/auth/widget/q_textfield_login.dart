import 'package:flutter/material.dart';

class QTextfieldAuth extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool isUseIcon;
  final IconData? icon;
  const QTextfieldAuth({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.isUseIcon,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          TextFormField(
            initialValue: null,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                filled: true,
                fillColor: Colors.white,
                hintText: hint,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.green)),
                suffixIcon: isUseIcon
                    ? Container(
                        margin: const EdgeInsets.only(
                          right: 20.0,
                        ),
                        child: Icon(
                          icon,
                          size: 24.0,
                        ),
                      )
                    : null),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
