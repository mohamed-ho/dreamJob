import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dreamjob/core/constants/string.dart';
import 'package:dreamjob/features/Home/view/screens/search_screen_withMoreItem.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:dreamjob/features/splash/widget/custum_Elevated_icon_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../core/constants/colors.dart';

FilterWidget(context) {
  double maxSalary = 10000;
  double minSalary = 500;
  RangeValues _currentRangeValues = RangeValues(0, maxSalary);
  String category = '';
  String supCategory = '';
  String address = '';
  String type = '';
  double salaryStart = 0;
  double salaryEnd = 0;
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
            child: ListView(
              children: [
                Align(
                    child: Text(
                  'Set filters',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                )),
                Text(
                  'Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                FutureBuilder(
                    future:
                        JobDataSource().getListOfAnycolunmInJob(jobcategory),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List data = snapshot.data as List;
                        return SearchField(
                          onSuggestionTap: (value) {
                            category = value.item.toString();
                          },
                          suggestions: data
                              .map((e) => SearchFieldListItem(e, item: e))
                              .toList(),
                          maxSuggestionsInViewPort: 6,
                          searchStyle: TextStyle(fontSize: 18),
                          suggestionStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                          suggestionsDecoration: BoxDecoration(
                              color: MyColors.mainColor,
                              borderRadius: BorderRadius.circular(16)),
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
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20))),
                        );
                      } else {
                        return TextField(
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
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20))),
                        );
                      }
                    }),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Sub Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                FutureBuilder(
                    future: JobDataSource()
                        .getListOfAnycolunmInJob(jobcloseCategory),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List data = snapshot.data as List;
                        return SearchField(
                          onSuggestionTap: (value) {
                            supCategory = value.item.toString();
                          },
                          suggestions: data
                              .map((e) => SearchFieldListItem(e, item: e))
                              .toList(),
                          maxSuggestionsInViewPort: 6,
                          searchStyle: TextStyle(fontSize: 18),
                          suggestionStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                          suggestionsDecoration: BoxDecoration(
                              color: MyColors.mainColor,
                              borderRadius: BorderRadius.circular(16)),
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
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20))),
                        );
                      } else {
                        return TextField(
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
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20))),
                        );
                      }
                    }),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Salary Range',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                FutureBuilder(
                    future: JobDataSource().getMaxSalary(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        JobModel job = snapshot.data as JobModel;
                        maxSalary = job.salary!;

                        return FutureBuilder(
                            future: JobDataSource().getMinSalary(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                JobModel job = snapshot.data as JobModel;

                                _currentRangeValues = RangeValues(0, maxSalary);
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return RangeSlider(
                                    values: _currentRangeValues,
                                    max: maxSalary,
                                    divisions: maxSalary.toInt(),
                                    labels: RangeLabels(
                                      _currentRangeValues.start
                                          .round()
                                          .toString(),
                                      _currentRangeValues.end
                                          .round()
                                          .toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        _currentRangeValues = values;
                                      });
                                    },
                                  );
                                });
                              } else {
                                return Text('Loading....');
                              }
                            });
                      } else {
                        return Text('loading....');
                      }
                    }),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Locatin',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectState(onCountryChanged: (country) {
                        address = country + '/';
                      }, onStateChanged: (state) {
                        address = address + state + '/';
                      }, onCityChanged: (city) {
                        address = address + city;
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Job Tyype',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: FutureBuilder(
                      future: JobDataSource().getListOfAnycolunmInJob(jobType),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List data = snapshot.data as List;
                          return SearchField(
                            onSuggestionTap: (value) {
                              type = value.item.toString();
                            },
                            suggestions: data
                                .map((e) => SearchFieldListItem(e, item: e))
                                .toList(),
                            maxSuggestionsInViewPort: 6,
                            searchStyle: TextStyle(fontSize: 18),
                            suggestionStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                            suggestionsDecoration: BoxDecoration(
                                color: MyColors.mainColor,
                                borderRadius: BorderRadius.circular(16)),
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
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20))),
                          );
                        } else {
                          return TextField(
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
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20))),
                          );
                        }
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: CustomElevatedIconButton(
                      onpress: () async {
                        if (category != '') {
                          List<JobModel> ListJob = await JobDataSource()
                              .searchJob(
                                  category,
                                  supCategory != '' ? supCategory : null,
                                  address != '' ? address : null,
                                  [
                                    _currentRangeValues.start,
                                    _currentRangeValues.end
                                  ],
                                  type != '' ? type : null);
                          print(ListJob);
                          Navigator.pushReplacementNamed(
                              context, SearchScreenWithMoreItem.id,
                              arguments: ListJob);
                        }
                      },
                      buttonText: 'Apply Filters'),
                )
              ],
            ),
          ),
        );
      });
}
