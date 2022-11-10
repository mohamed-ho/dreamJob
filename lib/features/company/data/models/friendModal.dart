import 'package:dreamjob/core/constants/string.dart';

class FriendModel {
  String? worker_Id;
  String? company_Id;

  FriendModel({required this.company_Id, required this.worker_Id});
  FriendModel.formJson({required Map<String, dynamic> json}) {
    this.company_Id = json[companyId];
    this.worker_Id = json[friendId];
  }
}
