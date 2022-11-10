import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamjob/core/constants/string.dart';

class MessageModal {
  String? company_id;
  String? worker_id;
  String? coutent;
  Timestamp? time;
  String? sender;

  MessageModal({
    this.sender,
    this.worker_id,
    this.company_id,
    this.coutent,
    this.time,
  });

  MessageModal.fromJson(
    Map<String, dynamic> json,
  ) {
    company_id = json[companyMessage];
    worker_id = json[workerMessage];
    sender = json[messageSender];
    coutent = json[messagecomponent];
    time = json[messageTime];
  }
}
