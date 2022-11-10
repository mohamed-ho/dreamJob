import 'package:dreamjob/core/constants/string.dart';
import 'package:flutter/cupertino.dart';

class OrderModel {
  String? CVUrl;
  String? Workername;
  String? email;
  String? address;
  String? jobId;
  String? message;
  String? workerId;

  OrderModel(
      {required this.CVUrl,
      required this.Workername,
      required this.address,
      required this.email,
      required this.jobId,
      required this.message,
      required this.workerId});
  OrderModel.formJson(Map json) {
    this.CVUrl = json[orderCv];
    this.Workername = json[orderworkerName];
    this.address = json[ordercounty];
    this.email = json[email];
    this.jobId = json[orderjobId];
    this.message = json[orderMessage];
    this.workerId = json[orderWorkerId];
  }
}
