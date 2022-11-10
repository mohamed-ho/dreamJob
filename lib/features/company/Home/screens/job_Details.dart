import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamjob/core/constants/colors.dart';
import 'package:dreamjob/features/company/Home/widgets/order_widget.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:dreamjob/features/company/data/models/order_model.dart';
import 'package:flutter/material.dart';

class JobDetails extends StatelessWidget {
  const JobDetails({super.key});
  static String id = 'jobDetails';
  @override
  Widget build(BuildContext context) {
    JobModel job = ModalRoute.of(context)!.settings.arguments as JobModel;
    return Scaffold(
      backgroundColor: MyColors.backgroundcolor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: MyColors.mainColor,
                    size: 30,
                  )),
              Text(
                'Facebook',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: ExactAssetImage('assets/images/Facebook.png'),
              ),
            ],
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: JobDataSource().getOrders(job.jobId!),
            builder: (context, snapshot) {
              print(job.jobId);
              if (snapshot.hasData) {
                List<OrderModel> orders = [];
                snapshot.data!.docs.forEach((element) {
                  var data = element.data() as Map<String, dynamic>;
                  orders.add(OrderModel.formJson(data));
                });
                return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return OrderWidget(
                        order: orders[index],
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('you have error' + snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: Text('loading....'),
                );
              }
            },
          ))
        ]),
      ),
    );
  }
}
