import 'package:dreamjob/features/chat/Screens/message_person.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MessagePerson.id);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink.shade200,
          radius: 30,
        ),
        title: Text('Rozanne Barrientes'),
        subtitle: Text('A wonderful serenity has taken'),
      ),
    );
  }
}
