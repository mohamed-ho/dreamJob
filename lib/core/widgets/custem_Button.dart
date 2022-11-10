import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.onpressed, required this.textChild});
  Function() onpressed;
  String textChild;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.mainColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          textChild,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
