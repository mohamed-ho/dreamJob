import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPasswordTextFormField extends StatefulWidget {
  AuthPasswordTextFormField(
      {super.key,
      required this.hintText,
      required this.onChange,
      @required this.controller});
  String hintText;
  TextEditingController? controller;
  Function(String) onChange;
  @override
  State<AuthPasswordTextFormField> createState() =>
      _AuthPasswordTextFormFieldState();
}

class _AuthPasswordTextFormFieldState extends State<AuthPasswordTextFormField> {
  bool hidenText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'the value  is not valid';
        }
      },
      onChanged: widget.onChange,
      obscureText: hidenText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hidenText = !hidenText;
            });
          },
          icon: hidenText
              ? Icon(Icons.visibility_off_outlined)
              : Icon(Icons.visibility_outlined),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
