import 'package:dreamjob/core/constants/colors.dart';
import 'package:dreamjob/features/company/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class OrderWidget extends StatelessWidget {
  OrderWidget({super.key, required this.order});
  OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: ListTile(
          leading: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/workerDefaultImage.jpg'),
              radius: 30),
          title: Text(order.Workername!),
          subtitle: Text(order.address!),
          trailing: Icon(
            Icons.book,
            size: 40,
            color: MyColors.mainColor,
          ),
        ),
      ),
    );
  }
}
