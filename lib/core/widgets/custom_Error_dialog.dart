import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dreamjob/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';

CustomErrorDialog(BuildContext context, String DialogBody, String dialogTitle) {
  AwesomeDialog(
      context: context,
      body: Text(DialogBody),
      title: dialogTitle,
      dialogType: DialogType.error)
    ..show();
}

CustomCorrectDialog(
    BuildContext context, String DialogBody, String dialogTitle) {
  AwesomeDialog(
    context: context,
    body: Text(
      DialogBody,
      style: TextStyle(fontSize: 16, color: MyColors.mainColor),
    ),
    title: dialogTitle,
    dialogType: DialogType.success,
    btnOkOnPress: () {
      Navigator.pop(context);
    },
  )..show();
}
