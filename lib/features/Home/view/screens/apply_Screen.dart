import 'dart:io';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dreamjob/core/constants/colors.dart';
import 'package:dreamjob/core/constants/string.dart';
import 'package:dreamjob/core/widgets/custom_Error_dialog.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:dreamjob/features/company/data/models/companyModel.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:dreamjob/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ApplyScreen extends StatefulWidget {
  ApplyScreen({super.key});
  static String id = 'ApplayScreen';

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  String address = '';

  GlobalKey<FormState> globalKey = GlobalKey();

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  String email = '';

  File? file;

  String message = '';

  FilePickerResult? result;

  bool progressHud = false;
  @override
  Widget build(BuildContext context) {
    JobModel job = ModalRoute.of(context)!.settings.arguments as JobModel;
    return ModalProgressHUD(
      inAsyncCall: progressHud,
      child: Scaffold(
          backgroundColor: MyColors.backgroundcolor,
          body: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Form(
              key: globalKey,
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 39),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                            )),
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          'Jobs Apply',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'First Name',
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          width: 160,
                          height: 50,
                          child: TextFormField(
                            controller: firstController,
                            validator: (value) {
                              if (value!.length < 2)
                                return 'please enter first Name';
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Name',
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          height: 50,
                          width: 160,
                          child: TextFormField(
                            controller: lastController,
                            validator: (value) {
                              if (value!.length < 2)
                                return 'please enter last Name';
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Your Email',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.replaceAll(' ', '').length == 0)
                        return 'please enter your Email';
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
                Text(
                  'Address',
                  style: TextStyle(fontSize: 18),
                ),
                Container(
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
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Message',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Container(
                    height: 150,
                    child: ListView(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            message = value;
                          },
                          maxLines: 50,
                          minLines: 10,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'CV',
                  style: TextStyle(fontSize: 18),
                ),
                InkWell(
                  onTap: () async {
                    result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['docx', 'pdf', 'doc'],
                    );
                    if (result != null) {
                      String path = result!.files.first.path!;
                      file = File(path);
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: file == null ? Colors.white : Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    height: 80,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(file == null
                              ? 'Upload Here'
                              : 'file is uploaded'),
                          Icon(Icons.file_copy)
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (globalKey.currentState!.validate()) {
                        if (address != '') {
                          if (file != null || result != null) {
                            setState(() {
                              progressHud = true;
                            });
                            try {
                              var data = await JobDataSource()
                                  .getCompanyDetails(comp_id: job.companyId!);
                              CompanyModel company =
                                  CompanyModel.fromJson(data);
                              String fileUrl = await JobDataSource().uploadFile(
                                  companyName: company.name!,
                                  jobTitle: job.title!,
                                  result: result);
                              await JobDataSource().addOrderJob(
                                  workerId: sharedpref.getString(workerIdKey)!,
                                  country: address,
                                  cvURL: fileUrl,
                                  email: email,
                                  jobId: job.jobId!,
                                  message: message,
                                  workerName: firstController.text +
                                      ' ' +
                                      lastController.text);
                              setState(() {
                                progressHud = false;
                              });
                              CustomCorrectDialog(
                                  context, 'Apply job Succeded', 'Apply Job');
                            } catch (e) {
                              setState(() {
                                progressHud = false;
                              });
                              CustomErrorDialog(
                                  context,
                                  'you have Error please try again' +
                                      e.toString(),
                                  'Error');
                            }
                          } else {
                            CustomErrorDialog(
                                context, 'please chose you CV', 'CV error');
                          }
                        } else {
                          CustomErrorDialog(context,
                              'please enter your Address', 'Address error');
                        }
                      }
                    },
                    child: Text(
                      'Apply Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(350, 60),
                        backgroundColor: MyColors.mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}
