import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dreamjob/core/constants/string.dart';
import 'package:dreamjob/core/widgets/custom_Error_dialog.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../auth/view/widgets/auth_textFormField.dart';
import '../../../splash/widget/custum_Elevated_icon_button.dart';

CustomShowButtonSheet({
  required BuildContext context,
  @required JobModel? job,
}) {
  GlobalKey<FormState> globalKey = GlobalKey();
  List<String> items = jobTypes;
  String type = items.first;
  String address = '';
  String title = '';
  double salary = 0;
  String description = '';
  String companyId = '';
  String category = '';
  String closeCategory = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController closeCatergoryController = TextEditingController();
  if (job != null) {
    titleController.text = job.title!;
    salaryController.text = job.salary.toString();
    descriptionController.text = job.descreption!;
    categoryController.text = job.category!;
    closeCatergoryController.text = job.closeCategory!;
    type = job.jobtype!;
    address = job.address!;
  }
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
            height: 650,
            child: StatefulBuilder(
              builder: (context, setState) => ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topCenter, child: Text('Add Job')),
                  ),
                  Form(
                      key: globalKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AuthTextFormField(
                                hintText: 'job title',
                                icon: Icon(Icons.title),
                                controller: titleController,
                                onchanged: (tit) {
                                  title = tit;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AuthTextFormField(
                                hintText: 'job description',
                                icon: Icon(Icons.description),
                                controller: descriptionController,
                                onchanged: (des) {
                                  description = des;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AuthTextFormField(
                                hintText: 'job Category',
                                icon: Icon(Icons.category),
                                controller: categoryController,
                                onchanged: (cat) {
                                  category = cat;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AuthTextFormField(
                                hintText: 'job Close category',
                                icon: Icon(Icons.category_outlined),
                                controller: closeCatergoryController,
                                onchanged: (closeCat) {
                                  closeCategory = closeCat;
                                }),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: salaryController,
                                decoration: InputDecoration(
                                    hintText: 'job salary',
                                    prefixIcon: Icon(Icons.attach_money),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    )),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    if (double.tryParse(value) == null)
                                      return 'salary is not number';
                                    else if (double.parse(value) < 0)
                                      return 'Salary can not be negative';
                                  } else if (value.isEmpty)
                                    return 'please enter salary';
                                },
                                onChanged: (value) {
                                  if (double.tryParse(value) != null) {
                                    salary = double.parse(value);
                                  }
                                },
                              )),
                          Text(
                            'Job Type',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: DropdownButtonFormField(
                              value: type,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24)),
                              ),
                              borderRadius: BorderRadius.circular(24),
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(
                                color: Color(0xff4CA6A8),
                                fontSize: 22,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  type = value!;
                                });
                              },
                              items: items.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Text(
                            'Address',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SelectState(onCountryChanged: (country) {
                                  setState(
                                    () => address = country + '/',
                                  );
                                }, onStateChanged: (state) {
                                  setState(
                                    () => address = address + state + '/',
                                  );
                                }, onCityChanged: (city) {
                                  setState(() => address = address + city);
                                }),
                              ),
                            ),
                          ),
                          job != null ? Text('Address: $address') : Text(''),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomElevatedIconButton(
                                onpress: () async {
                                  if (globalKey.currentState!.validate()) {
                                    if (job == null) {
                                      if (address.isNotEmpty) {
                                        await JobDataSource().getJobOwnerID;
                                        await JobDataSource().addJob(
                                            title: title,
                                            salary: salary,
                                            description: description,
                                            address: address,
                                            type: type,
                                            category: category,
                                            closeCategory: closeCategory);
                                        CustomCorrectDialog(
                                            context,
                                            'Adding job success',
                                            'Correct Adding');
                                      }
                                    } else {
                                      try {
                                        await JobDataSource().updateJob(
                                            title: titleController.text,
                                            salary: double.parse(
                                                salaryController.text),
                                            description:
                                                descriptionController.text,
                                            address: address,
                                            type: type,
                                            category: categoryController.text,
                                            closeCategory:
                                                closeCatergoryController.text,
                                            companyId: job.companyId!,
                                            numberOfOrder: job.numberOfOrder!,
                                            jobId: job.jobId!);
                                        CustomCorrectDialog(
                                            context,
                                            'Editing job success',
                                            'Correct Adding');
                                      } catch (e) {
                                        CustomErrorDialog(context, e.toString(),
                                            e.toString());
                                      }
                                    }
                                  }
                                },
                                buttonText:
                                    job == null ? 'Add Job' : 'Edit Job'),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      elevation: 3);
}
