import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QDatePicker extends StatefulWidget {
  final String label;
  final DateTime? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final Function(DateTime) onChanged;
  TextEditingController? controller;

  QDatePicker({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  State<QDatePicker> createState() => _QDatePickerState();
}

class _QDatePickerState extends State<QDatePicker> {
  DateTime? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    widget.controller = TextEditingController(
      text: getInitialValue(),
    );
  }

  getInitialValue() {
    if (widget.value != null) {
      return DateFormat("d MMM y").format(widget.value!);
    }
    return "-";
  }

  getFormattedValue() {
    if (selectedValue != null) {
      return DateFormat("d MMM y").format(selectedValue!);
    }
    return "-";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        InkWell(
          // focusColor: Colors.transparent,
          // hoverColor: Colors.transparent,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            selectedValue = pickedDate;
            widget.controller!.text = getFormattedValue();
            setState(() {});

            if (selectedValue == null) return;
            widget.onChanged(selectedValue!);
          },
          child: AbsorbPointer(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: TextFormField(
                controller: widget.controller,
                validator: (value) {
                  if (widget.validator != null) {
                    return widget.validator!(selectedValue.toString());
                  }
                  return null;
                },
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.date_range,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  helperText: widget.helper,
                  hintText: widget.hint,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
