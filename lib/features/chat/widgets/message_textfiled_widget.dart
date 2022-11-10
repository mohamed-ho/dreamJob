import 'package:dreamjob/core/constants/colors.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:flutter/material.dart';

class MessageTextFieldWidget extends StatelessWidget {
  MessageTextFieldWidget(
      {super.key, required this.onchange, required this.onSend});
  Function(String) onchange;
  Function() onSend;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        child: Row(children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: MyColors.mainColor,
            child: Icon(Icons.add),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: onchange,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Type a message',
                suffixIcon:
                    IconButton(onPressed: onSend, icon: Icon(Icons.send)),
              ),
            ),
          ))
        ]),
      ),
    );
  }
}
