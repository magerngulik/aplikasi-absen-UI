import 'package:flutter/material.dart';

class QTextfieldAuth extends StatefulWidget {
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
  State<QTextfieldAuth> createState() => _QTextfieldAuthState();
}

class _QTextfieldAuthState extends State<QTextfieldAuth> {
  bool? hide;
  @override
  void initState() {
    hide = widget.isUseIcon ? true : false;
    super.initState();
  }

  void changeHide() {
    hide = !hide!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          TextFormField(
            controller: widget.controller,
            initialValue: null,
            obscureText: hide!,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                filled: true,
                hintText: widget.hint,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.green)),
                suffixIcon: widget.isUseIcon
                    ? InkWell(
                        onTap: () => changeHide(),
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 20.0,
                          ),
                          child: Icon(
                            widget.icon,
                            size: 24.0,
                          ),
                        ),
                      )
                    : null),
          ),
        ],
      ),
    );
  }
}
