import 'package:flutter/material.dart';

class PopularJopWidget extends StatelessWidget {
  PopularJopWidget(
      {super.key,
      required this.image,
      required this.company,
      required this.price,
      required this.title,
      required this.address,
      required this.onTap});
  String image;
  String company;
  double price;
  String title;
  String address;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 260,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        image,
                        fit: BoxFit.fill,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  ],
                ),
                Text(
                  company,
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      '\$$price/m',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      address,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
