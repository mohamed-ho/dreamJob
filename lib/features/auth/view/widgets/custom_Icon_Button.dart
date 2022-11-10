import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {super.key, required this.iconPath, required this.onpressed});
  String iconPath;
  Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onpressed,
      child: Image.asset(
        iconPath,
        fit: BoxFit.fill,
      ),
    );
  }
}
