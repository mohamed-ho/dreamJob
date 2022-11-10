import 'package:dreamjob/features/Home/view/widgets/Search_job_widget.dart';
import 'package:dreamjob/features/Home/view/widgets/recent_jop_widget.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/string.dart';
import '../../../company/data/Data_source/job_data_source.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchController = TextEditingController();
  static String id = 'searchScreen';
  @override
  Widget build(BuildContext context) {
    String searchItem = ModalRoute.of(context)!.settings.arguments as String;
    searchController.text = searchItem;
    return Scaffold(
      backgroundColor: MyColors.backgroundcolor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 36),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios_new)),
                Text(
                  'Search',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FutureBuilder(
                        future: JobDataSource()
                            .getListOfAnycolunmInJob(jobcategory),
                        builder: (context, snapthot) {
                          if (snapthot.hasData) {
                            List data = snapthot.data as List;
                            return Container(
                                width: 320,
                                child: SearchField(
                                  controller: searchController,
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
                                      .map((e) =>
                                          SearchFieldListItem(e, item: e))
                                      .toList(),
                                  autoCorrect: true,
                                  onSuggestionTap: (value) {
                                    searchItem = value.item.toString();
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  },
                                  searchInputDecoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Serach here....',
                                      hintStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            );
                          }
                        }),
                    Image.asset('assets/images/Go BTN.png')
                  ]),
            ),
            Expanded(
                child: FutureBuilder(
              future: JobDataSource().searchJob(searchItem),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<JobModel> jobsList = [];
                  jobsList = snapshot.data as List<JobModel>;

                  return Column(
                    children: [
                      Text(
                        '${jobsList.length} Job Opportunity',
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: jobsList.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                  future: JobDataSource().getCompanyDetails(
                                      comp_id: jobsList[index].companyId!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var data =
                                          snapshot.data as Map<String, dynamic>;
                                      return SearchJobWidget(
                                          address: jobsList[index].address!,
                                          category: jobsList[index].category!,
                                          companyName: data[jobOwnerUserName],
                                          hours: '5h',
                                          imageUrl: data[jobOwnerImage] ==
                                                  noImage
                                              ? 'assets/images/companydefaultImage.jpg'
                                              : 'assets/images/Facebook.png',
                                          salary: jobsList[index]
                                              .salary
                                              .toString());
                                    } else {
                                      return Center(
                                        child: Text('loading....'),
                                      );
                                    }
                                  });
                            }),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text('loading.....'),
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
