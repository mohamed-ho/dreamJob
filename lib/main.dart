import 'package:dreamjob/core/constants/string.dart';
import 'package:dreamjob/core/routes.dart';
import 'package:dreamjob/features/splash/screens/splash_screen.dart';
import 'package:dreamjob/firebase_options.dart';
import 'package:dreamjob/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'features/Home/view/screens/control_screen.dart';
import 'features/company/Home/screens/control_company_screen.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sharedpref = await SharedPreferences.getInstance();
  sharedpref.clear();
  runApp(const DreamJob());
}

class DreamJob extends StatelessWidget {
  const DreamJob({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: MyRoutes.routes,
          initialRoute: sharedpref.getBool(checkLogin) == null
              ? SplashScreen.id
              : sharedpref.getBool(checkLogin)! &&
                      sharedpref.getBool(isCompany)!
                  ? ControlCompanyScreen.id
                  : ControlScreen.id),
    );
  }
}
