import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final String hint;
  final String label;
  final validator;
  final int maxLength;
  final IconData icon;
  FormInput({
    this.controller,
    this.icon,
    this.hint,
    this.label,
    this.validator,
    this.maxLength,
    this.keyboard = TextInputType.text,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: TextFormField(
        maxLength: maxLength,
        validator: validator,
        keyboardType: keyboard,
        controller: controller,
        decoration: new InputDecoration(
          hintText: hint,
          labelText: label,
        ),
      ),
    );
  }
}

class TextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final validator;
  final IconData icon;
  TextArea(
      {@required this.controller,
      this.validator,
      this.hint,
      this.label,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: TextFormField(
        validator: validator,
        maxLines: 3,
        controller: controller,
        decoration: new InputDecoration(
          hintText: hint,
          labelText: label,
        ),
      ),
    );
  }
}
