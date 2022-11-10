import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dreamjob/core/constants/colors.dart';
import 'package:dreamjob/features/auth/view/widgets/auth_textFormField.dart';
import 'package:dreamjob/features/company/Home/screens/job_Details.dart';
import 'package:dreamjob/features/company/Home/widgets/costomShowButtonSheet.dart';
import 'package:dreamjob/features/company/Home/widgets/job_widget.dart';
import 'package:dreamjob/features/company/Home/widgets/order_widget.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:dreamjob/features/splash/widget/custum_Elevated_icon_button.dart';
import 'package:dreamjob/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/string.dart';

class HomeCompanyWidget extends StatefulWidget {
  const HomeCompanyWidget({super.key});

  @override
  State<HomeCompanyWidget> createState() => _HomeCompanyWidgetState();
}

class _HomeCompanyWidgetState extends State<HomeCompanyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
      child: Container(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  child: Image.asset('assets/images/Menu.png'),
                  onTap: () async {
                    JobDataSource().addNewFriend(
                        friend_id: 'lZdiGia85gtP0BC7OhZf',
                        companpy_id: sharedpref.getString(companyIdKey));
                  }),
              Text(
                sharedpref.getString(companyNameKey) == null
                    ? 'facebook'
                    : sharedpref.getString(companyNameKey)!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      sharedpref.getString(companyUrlKey) == noImage
                          ? AssetImage('assets/images/companydefaultImage.jpg')
                          : AssetImage('assets/images/Facebook.png')),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: JobDataSource().getJobs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<JobModel> jobs = [];
                  snapshot.data!.docs.forEach((element) {
                    var data = element.data() as Map<String, dynamic>;
                    if (data['companyId'] ==
                        sharedpref.getString(companyIdKey)) {
                      jobs.add(JobModel.fromJson(data, element.id));
                    }
                  });

                  return Expanded(
                      child: ListView.builder(
                          itemCount: jobs.length,
                          itemBuilder: (context, indext) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: JobWidget(
                                onTap: () {
                                  Navigator.pushNamed(context, JobDetails.id,
                                      arguments: jobs[indext]);
                                },
                                title: jobs[indext].title!,
                                salary: jobs[indext].salary!,
                                numberOfOrders: jobs[indext].numberOfOrder!,
                                deleteFunction: () async {
                                  JobDataSource()
                                      .deleteJob(jobs[indext].jobId!);
                                },
                                editFunction: () {
                                  CustomShowButtonSheet(
                                      context: context, job: jobs[indext]);
                                },
                              ),
                            );
                          }));
                } else {
                  return Center(
                    child: Text('Loading.....'),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: InkWell(
              onTap: () {
                CustomShowButtonSheet(
                  context: context,
                );
              },
              child: Container(
                height: 50,
                child: Center(
                    child: Text(
                  'ADD JOB',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
                decoration: BoxDecoration(
                    color: MyColors.mainColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 15,
                          color: MyColors.mainColor,
                          spreadRadius: 3),
                    ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
