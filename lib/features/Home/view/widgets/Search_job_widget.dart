import 'package:flutter/material.dart';

class SearchJobWidget extends StatelessWidget {
  SearchJobWidget(
      {super.key,
      required this.address,
      required this.category,
      required this.companyName,
      required this.hours,
      required this.imageUrl,
      required this.salary});
  String imageUrl;
  String companyName;
  String category;
  String salary;
  String address;
  String hours;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(companyName),
                            Text(
                              category,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(salary),
                        Text(address.length > 20
                            ? address.substring(0, 20) + '...'
                            : address),
                        Text(hours),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
