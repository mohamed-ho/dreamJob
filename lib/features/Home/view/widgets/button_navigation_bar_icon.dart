import 'package:flutter/material.dart';

class customButtonNavigationBarIcon extends StatelessWidget {
  customButtonNavigationBarIcon(
      {Key? key,
      required this.icon,
      required this.discreption,
      required this.onTap})
      : super(key: key);
  Widget discreption;
  Function() onTap;

  Icon icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          icon,
          discreption,
        ]),
      ),
    );
  }
}
