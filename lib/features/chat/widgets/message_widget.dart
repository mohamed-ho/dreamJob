import 'package:dreamjob/core/constants/colors.dart';
import 'package:dreamjob/core/constants/string.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget(
      {super.key,
      required this.isSender,
      required this.messageContant,
      required this.messageTime});
  bool isSender;
  String messageContant;
  String messageTime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: isSender ? MyColors.SenderMessageColor : Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Align(
              child: Text(
                messageContant,
                style: TextStyle(fontSize: 16),
              ),
              alignment: Alignment.topLeft,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(messageTime),
            )
          ]),
        ),
      ),
    );
  }
}
