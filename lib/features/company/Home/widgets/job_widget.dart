import 'package:flutter/material.dart';

class JobWidget extends StatelessWidget {
  JobWidget(
      {super.key,
      required this.title,
      required this.salary,
      required this.numberOfOrders,
      required this.onTap,
      required this.editFunction,
      required this.deleteFunction});
  String title;
  double salary;
  int numberOfOrders;
  Function() editFunction;
  Function() deleteFunction;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.edit,
                        color: Colors.yellow,
                      ),
                      onTap: editFunction,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: InkWell(
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: deleteFunction,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$salary'),
                Text('$numberOfOrders Orders'),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
