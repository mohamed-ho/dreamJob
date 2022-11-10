import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  AuthTextFormField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.onchanged,
      @required this.controller});
  String hintText;
  Icon icon;
  TextEditingController? controller;
  Function(String) onchanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'the value  is not valid';
        }
      },
      controller: controller,
      onChanged: onchanged,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
