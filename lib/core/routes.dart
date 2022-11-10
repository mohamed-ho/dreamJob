import 'package:dreamjob/features/Home/view/screens/apply_Screen.dart';
import 'package:dreamjob/features/Home/view/screens/control_screen.dart';
import 'package:dreamjob/features/Home/view/screens/home_screen.dart';
import 'package:dreamjob/features/Home/view/screens/messages_screen.dart';
import 'package:dreamjob/features/Home/view/screens/search_Screen.dart';
import 'package:dreamjob/features/Home/view/screens/search_screen_withMoreItem.dart';
import 'package:dreamjob/features/auth/view/screens/login_screen.dart';
import 'package:dreamjob/features/auth/view/screens/signup_screen.dart';
import 'package:dreamjob/features/chat/Screens/message_person.dart';
import 'package:dreamjob/features/company/Home/screens/control_company_screen.dart';
import 'package:dreamjob/features/company/Home/screens/job_Details.dart';
import 'package:dreamjob/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.id: (context) => SplashScreen(),
    LoginScreen.id: (context) => LoginScreen(),
    SignUPScreen.id: (context) => SignUPScreen(),
    ControlScreen.id: (context) => ControlScreen(),
    HomeScreen.id: (context) => HomeScreen(),
    MessagesScreen.id: (context) => MessagesScreen(),
    MessagePerson.id: (context) => MessagePerson(),
    ControlCompanyScreen.id: (context) => ControlCompanyScreen(),
    JobDetails.id: (context) => JobDetails(),
    SearchScreen.id: (context) => SearchScreen(),
    SearchScreenWithMoreItem.id: (context) => SearchScreenWithMoreItem(),
    ApplyScreen.id: (context) => ApplyScreen(),
  };
}
