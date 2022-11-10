import 'package:dreamjob/core/constants/colors.dart';
import 'package:dreamjob/core/constants/string.dart';
import 'package:dreamjob/features/Home/view/screens/search_Screen.dart';
import 'package:dreamjob/features/Home/view/widgets/apply_widget.dart';
import 'package:dreamjob/features/Home/view/widgets/filter_widget.dart';
import 'package:dreamjob/features/Home/view/widgets/popular_jop_widget.dart';
import 'package:dreamjob/features/Home/view/widgets/recent_jop_widget.dart';
import 'package:dreamjob/features/auth/data/data_surce/firbase_data_surce.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:dreamjob/main.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static String id = 'home_screen';
  String searchItem = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      child: Image.asset('assets/images/Menu.png'),
                      onTap: () async {
                        await FirebaseTest()
                            .uploadFile(companyName: 'fdsf', jobTitle: 'fdsf');
                      }),
                  CircleAvatar(
                      radius: 25,
                      backgroundImage: sharedpref.getString(workerUrlKey) ==
                              noImage
                          ? AssetImage('assets/images/workerDefaultImage.jpg')
                          : AssetImage('assets/images/Google.png'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder(
                      future:
                          JobDataSource().getListOfAnycolunmInJob(jobcategory),
                      builder: (context, snapthot) {
                        if (snapthot.hasData) {
                          List data = snapthot.data as List;
                          return Container(
                              width: 320,
                              child: SearchField(
                                maxSuggestionsInViewPort: 6,
                                searchStyle: TextStyle(fontSize: 18),
                                suggestionStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                                suggestionsDecoration: BoxDecoration(
                                    color: MyColors.mainColor,
                                    borderRadius: BorderRadius.circular(16)),
                                suggestions: data
                                    .map((e) => SearchFieldListItem(e, item: e))
                                    .toList(),
                                autoCorrect: true,
                                onSuggestionTap: (value) {
                                  searchItem = value.item.toString();
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  Navigator.pushNamed(context, SearchScreen.id,
                                      arguments: searchItem);
                                },
                                searchInputDecoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Serach here....',
                                    hintStyle: TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ));
                        } else {
                          return Container(
                            width: 320,
                            child: TextField(
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Serach here....',
                                  hintStyle: TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          );
                        }
                      }),
                  InkWell(
                    child: Image.asset('assets/images/Go BTN.png'),
                    onTap: () {
                      FilterWidget(context);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Job',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('show All'),
                ],
              ),
            ),
            Container(
                height: 180,
                width: double.infinity,
                child: StreamBuilder(
                  stream: JobDataSource().getJobs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<JobModel> jobs = [];

                      snapshot.data!.docs.forEach((element) {
                        var data = element.data() as Map<String, dynamic>;
                        jobs.add(JobModel.fromJson(element.data(), element.id));
                      });
                      return ListView.builder(
                        itemCount: jobs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: JobDataSource().getCompanyDetails(
                                  comp_id: jobs[index].companyId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data =
                                      snapshot.data as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: PopularJopWidget(
                                        onTap: () {
                                          ApplyWidget(
                                              job: jobs[index],
                                              context: context);
                                        },
                                        image: data[jobOwnerImage] == noImage
                                            ? 'assets/images/companydefaultImage.jpg'
                                            : 'assets/images/Google.png',
                                        company: data[jobOwnerUserName],
                                        price: jobs[index].salary!,
                                        title: jobs[index].title!,
                                        address:
                                            jobs[index].address!.length > 15
                                                ? jobs[index]
                                                        .address!
                                                        .substring(0, 23) +
                                                    '...'
                                                : jobs[index].address!),
                                  );
                                } else {
                                  return Container(
                                    height: 180,
                                    child: Center(
                                      child: Text('loading....'),
                                    ),
                                  );
                                }
                              });
                        },
                      );
                    } else {
                      return Container(
                        height: 180,
                        child: Center(
                          child: Text('loading....'),
                        ),
                      );
                    }
                  },
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Post',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Show All',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            //--------------------------------------------------------
            Container(
                height: 270,
                child: StreamBuilder(
                  stream: JobDataSource().getJobs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<JobModel> jobs = [];

                      snapshot.data!.docs.forEach((element) {
                        var data = element.data() as Map<String, dynamic>;
                        jobs.add(JobModel.fromJson(element.data(), element.id));
                      });
                      return ListView.builder(
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: JobDataSource().getCompanyDetails(
                                  comp_id: jobs[index].companyId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data =
                                      snapshot.data as Map<String, dynamic>;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: RecentJopWidget(
                                        image: data[jobOwnerImage] == noImage
                                            ? 'assets/images/companydefaultImage.jpg'
                                            : 'assets/images/Facebook.png',
                                        jopType: jobs[index].jobtype!,
                                        price: jobs[index].salary!,
                                        title: jobs[index].title!),
                                  );
                                } else {
                                  return Container(
                                    height: 270,
                                    child: Center(
                                      child: Text('loading....'),
                                    ),
                                  );
                                }
                              });
                        },
                      );
                    } else {
                      return Container(
                        height: 270,
                        child: Center(
                          child: Text('loading....'),
                        ),
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
