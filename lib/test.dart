import 'dart:io';
import 'package:dreamjob/features/auth/data/data_surce/firbase_data_surce.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: MaterialButton(
          onPressed: () async {
            await FirebaseTest().getAllFileInRef();
          },
          child: Text('click'),
          color: Colors.amberAccent,
        ),
      )),
    );
  }
}
