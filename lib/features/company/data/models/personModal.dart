import 'package:dreamjob/core/constants/string.dart';

class PersonModel {
  String? name;
  String? email;
  String? imageUrl;

  PersonModel({this.email, this.name, this.imageUrl});
  PersonModel.fromJson(Map<String, dynamic> json) {
    this.name = json[workerUserName];
    this.email = json[workerEmail];
    this.imageUrl = json[workerImage];
  }
}
