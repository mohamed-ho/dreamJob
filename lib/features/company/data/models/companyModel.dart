import 'package:dreamjob/core/constants/string.dart';

class CompanyModel {
  String? name;
  String? email;
  String? imageUrl;

  CompanyModel({this.email, this.name, this.imageUrl});
  CompanyModel.fromJson(Map<String, dynamic> json) {
    this.name = json[workerUserName];
    this.email = json[workerEmail];
    this.imageUrl = json[workerImage];
  }
}
