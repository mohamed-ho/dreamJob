import 'package:dreamjob/features/Home/view/screens/apply_Screen.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:dreamjob/features/company/data/models/companyModel.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

ApplyWidget({required JobModel job, required BuildContext context}) {
  int buttonIndex = 0;
  showModalBottomSheet(
      backgroundColor: MyColors.backgroundcolor,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            height: 700,
            child: StatefulBuilder(
              builder: (context, setState) => ListView(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/companydefaultImage.jpg',
                    ),
                    radius: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        job.title!,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text(job.address!),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.alarm),
                            Text(job.jobtype!, style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Text(
                          '\$${job.salary}/m',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonIndex = 0;
                            });
                          },
                          child: Text('Description',
                              style: TextStyle(
                                  color: buttonIndex == 0
                                      ? Colors.white
                                      : Colors.black)),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: buttonIndex == 0
                                ? MyColors.mainColor
                                : MyColors.backgroundcolor,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonIndex = 1;
                            });
                          },
                          child: Text('Company',
                              style: TextStyle(
                                  color: buttonIndex == 1
                                      ? Colors.white
                                      : Colors.black)),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: buttonIndex == 1
                                ? MyColors.mainColor
                                : MyColors.backgroundcolor,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonIndex = 2;
                            });
                          },
                          child: Text('Reviews',
                              style: TextStyle(
                                  color: buttonIndex == 2
                                      ? Colors.white
                                      : Colors.black)),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: buttonIndex == 2
                                ? MyColors.mainColor
                                : MyColors.backgroundcolor,
                          )),
                    ],
                  ),
                  buttonIndex == 0
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            height: 300,
                            child: ListView(children: [
                              Text(
                                'Qualifications:',
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                child: Text(job.descreption! +
                                    'sdfaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
                              )
                            ]),
                          ),
                        )
                      : buttonIndex == 1
                          ? FutureBuilder(
                              future: JobDataSource()
                                  .getCompanyDetails(comp_id: job.companyId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data =
                                      snapshot.data as Map<String, dynamic>;
                                  CompanyModel companyDetails =
                                      CompanyModel.fromJson(data);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Container(
                                      height: 300,
                                      child: ListView(children: [
                                        Text(
                                          'Company Name:-',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          companyDetails.name!,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text('Company Email',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          companyDetails.email!,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    height: 320,
                                    child: Center(
                                      child: Text('loading.....'),
                                    ),
                                  );
                                }
                              })
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                height: 300,
                                child: ListView(children: [
                                  Text(
                                    'this job oredrer by 43 person ',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                              ),
                            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, ApplyScreen.id,
                              arguments: job);
                        },
                        child: Text(
                          'Apply Now',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 60),
                            backgroundColor: MyColors.mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.message,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            backgroundColor: MyColors.mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
