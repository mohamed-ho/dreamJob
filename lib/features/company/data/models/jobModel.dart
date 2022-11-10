class JobModel {
  String? companyId;
  String? descreption;
  String? address;
  int? numberOfOrder;
  String? closeCategory;
  double? salary;
  String? title;
  String? category;
  String? jobtype;
  String? jobId;

  JobModel(
      {this.companyId,
      this.descreption,
      this.address,
      this.numberOfOrder,
      this.closeCategory,
      this.salary,
      this.title,
      this.category,
      this.jobtype,
      this.jobId});

  JobModel.fromJson(Map<String, dynamic> json, String id) {
    companyId = json['companyId'];
    descreption = json['descreption'];
    address = json['address'];
    numberOfOrder = json['numberOfOrder'];
    closeCategory = json['closeCategory'];
    salary = json['salary'];
    title = json['title'];
    category = json['category'];
    jobtype = json['jobtype'];
    jobId = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['descreption'] = this.descreption;
    data['address'] = this.address;
    data['numberOfOrder'] = this.numberOfOrder;
    data['closeCategory'] = this.closeCategory;
    data['salary'] = this.salary;
    data['title'] = this.title;
    data['category'] = this.category;
    data['jobtype'] = this.jobtype;
    return data;
  }
}
