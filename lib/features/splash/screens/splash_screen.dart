import 'package:dreamjob/core/widgets/custem_Button.dart';
import 'package:dreamjob/features/auth/data/data_surce/firbase_data_surce.dart';
import 'package:dreamjob/features/auth/view/screens/login_screen.dart';
import 'package:dreamjob/features/splash/widget/custum_Elevated_icon_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  static String id = 'splash_screen';
  bool isJobOwner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 33.2),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/Logo.png',
                width: 30,
                height: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 49),
            child: Image.asset(
              'assets/images/Ai.png',
              width: double.infinity,
              height: 378,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Text('Find a Perfact Job Match',
                style: TextStyle(fontSize: 34), textAlign: TextAlign.center),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Text(
                'Finding your dream job is more easire and faster with DreamJop',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomElevatedIconButton(
                buttonText: 'Let`s Get Start as a worker',
                onpress: () {
                  isJobOwner = false;
                  Navigator.pushNamed(context, LoginScreen.id,
                      arguments: isJobOwner);
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomElevatedIconButton(
                buttonText: 'Let`s Get Start as a job owner',
                onpress: () {
                  isJobOwner = true;
                  Navigator.pushNamed(context, LoginScreen.id,
                      arguments: isJobOwner);
                },
              )),
        ],
      ),
    );
  }
}
