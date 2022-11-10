import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamjob/core/constants/string.dart';
import 'package:dreamjob/core/widgets/custom_Error_dialog.dart';
import 'package:dreamjob/features/chat/widgets/message_textfiled_widget.dart';
import 'package:dreamjob/features/chat/widgets/message_widget.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:dreamjob/features/company/data/models/companyModel.dart';
import 'package:dreamjob/features/company/data/models/friendModal.dart';
import 'package:dreamjob/features/company/data/models/messagModel.dart';
import 'package:dreamjob/main.dart';
import 'package:flutter/material.dart';

class MessagePerson extends StatelessWidget {
  MessagePerson({super.key});
  static String id = 'message_person_screen';
  String newMassage = '';
  @override
  Widget build(BuildContext context) {
    FriendModel friend =
        ModalRoute.of(context)!.settings.arguments as FriendModel;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: 80,
                  ),
                  Expanded(
                      child: FutureBuilder(
                    future: JobDataSource()
                        .getCompanyDetails(comp_id: friend.company_Id!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data as Map<String, dynamic>;
                        CompanyModel company = CompanyModel.fromJson(data);
                        return Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    'assets/images/companydefaultImage.jpg'),
                              ),
                            ),
                            Text(
                              company.name!,
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: Text('loading......'),
                        );
                      }
                    },
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone,
                        size: 30,
                      )),
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: JobDataSource().getMessages(
                  company_id: friend.company_Id, worker_id: friend.worker_Id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MessageModal> messages = [];
                  snapshot.data!.docs.forEach((element) {
                    var data = element.data() as Map<String, dynamic>;
                    messages.add(MessageModal.fromJson(data));
                  });
                  return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageWidget(
                            messageContant: messages[index].coutent!,
                            messageTime:
                                new DateTime.fromMicrosecondsSinceEpoch(
                                        messages[index]
                                            .time!
                                            .microsecondsSinceEpoch)
                                    .toString(),
                            isSender: sharedpref.getString(workerIdKey) ==
                                    messages[index].sender
                                ? true
                                : false);
                      });
                } else {
                  return Center(
                    child: Text('No data'),
                  );
                }
              },
            ))
          ],
        ),
      ),
      bottomNavigationBar: MessageTextFieldWidget(
        onSend: () async {
          if (newMassage.isNotEmpty) {
            await JobDataSource().addMessage(
                message: newMassage,
                worker_id: friend.worker_Id,
                company_id: friend.company_Id,
                timeOfMessage: Timestamp.now(),
                sender: friend.company_Id);
          } else {
            CustomErrorDialog(context, 'please enter message', 'Message Error');
          }
        },
        onchange: (value) {
          newMassage = value;
        },
      ),
    );
  }
}
