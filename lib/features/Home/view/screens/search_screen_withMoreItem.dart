import 'package:dreamjob/core/constants/colors.dart';
import 'package:dreamjob/features/Home/view/widgets/Search_job_widget.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/string.dart';
import '../../../company/data/Data_source/job_data_source.dart';

class SearchScreenWithMoreItem extends StatelessWidget {
  const SearchScreenWithMoreItem({super.key});
  static String id = 'searchScreenWithMoreItem';
  @override
  Widget build(BuildContext context) {
    List<JobModel> jobList =
        ModalRoute.of(context)!.settings.arguments as List<JobModel>;
    return Scaffold(
        backgroundColor: MyColors.backgroundcolor,
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
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          )),
                      Text(
                        'Jobs',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: jobList.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                            future: JobDataSource().getCompanyDetails(
                                comp_id: jobList[index].companyId!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data =
                                    snapshot.data as Map<String, dynamic>;
                                return SearchJobWidget(
                                    address: jobList[index].address!,
                                    category: jobList[index].category!,
                                    companyName: data[jobOwnerUserName],
                                    hours: '5h',
                                    imageUrl: data[jobOwnerImage] == noImage
                                        ? 'assets/images/companydefaultImage.jpg'
                                        : 'assets/images/Facebook.png',
                                    salary: jobList[index].salary.toString());
                              } else {
                                return Center(
                                  child: Text('loading....'),
                                );
                              }
                            });
                      }),
                ),
              ],
            )));
  }
}
