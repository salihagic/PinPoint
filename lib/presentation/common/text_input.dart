import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextInputType type;
  final int minLines;
  final String hintText;
  final String? initialValue;
  final void Function(String text) onChanged;

  const TextInput({
    super.key,
    this.type = TextInputType.text,
    this.minLines = 1,
    this.initialValue,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white70,
        hintText: hintText,
      ),
      keyboardType: type,
      minLines: minLines,
      maxLines: minLines + 1,
      onChanged: onChanged,
    );
  }
}
