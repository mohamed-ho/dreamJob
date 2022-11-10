import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class CustomElevatedIconButton extends StatelessWidget {
  CustomElevatedIconButton(
      {super.key, required this.onpress, required this.buttonText});
  Function() onpress;
  String buttonText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 16),
        ),
      ),
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.mainColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      label: Icon(Icons.arrow_forward_rounded),
    );
  }
}
