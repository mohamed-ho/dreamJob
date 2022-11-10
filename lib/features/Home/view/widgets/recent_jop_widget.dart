import 'package:flutter/material.dart';

class RecentJopWidget extends StatelessWidget {
  RecentJopWidget(
      {super.key,
      required this.image,
      required this.jopType,
      required this.price,
      required this.title});
  String image;
  String title;
  String jopType;
  double price;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          child: Image.asset(image),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          jopType,
          style: TextStyle(fontSize: 12),
        ),
        trailing: Text(
          '\$$price/m',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
