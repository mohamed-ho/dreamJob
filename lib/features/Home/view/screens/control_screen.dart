import 'package:dreamjob/core/constants/colors.dart';
import 'package:dreamjob/features/Home/view/screens/home_screen.dart';
import 'package:dreamjob/features/Home/view/screens/messages_screen.dart';
import 'package:dreamjob/features/Home/view/screens/profile_screen.dart';
import 'package:dreamjob/features/Home/view/screens/setting_screen.dart';
import 'package:dreamjob/features/Home/view/widgets/button_navigation_bar_icon.dart';
import 'package:dreamjob/features/chat/Screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  ControlScreen({super.key});
  static String id = 'control_screen';

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final pages = [HomeScreen(), ChatScreen(), profileScreen(), SettingScreen()];

  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundcolor,
        body: pages[pageindex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              color: Colors.white),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButtonNavigationBarIcon(
                  icon: pageindex == 0
                      ? Icon(
                          Icons.home,
                          color: MyColors.mainColor,
                        )
                      : Icon(
                          Icons.home,
                          color: Colors.grey.shade600,
                        ),
                  discreption: pageindex == 0
                      ? Image.asset('assets/images/Vector 3.png')
                      : Text('home'),
                  onTap: () {
                    setState(() {
                      pageindex = 0;
                    });
                  }),
              customButtonNavigationBarIcon(
                  icon: pageindex == 1
                      ? Icon(
                          Icons.textsms_rounded,
                          color: MyColors.mainColor,
                        )
                      : Icon(
                          Icons.textsms_rounded,
                          color: Colors.grey,
                        ),
                  discreption: pageindex == 1
                      ? Image.asset('assets/images/Vector 3.png')
                      : Text('Message'),
                  onTap: () {
                    setState(() {
                      pageindex = 1;
                    });
                  }),
              customButtonNavigationBarIcon(
                  icon: pageindex == 2
                      ? Icon(
                          Icons.person,
                          color: MyColors.mainColor,
                        )
                      : Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                  discreption: pageindex == 2
                      ? Image.asset('assets/images/Vector 3.png')
                      : Text('profile'),
                  onTap: () {
                    setState(() {
                      pageindex = 2;
                    });
                  }),
              customButtonNavigationBarIcon(
                  discreption: pageindex == 3
                      ? Image.asset('assets/images/Vector 3.png')
                      : Text('setting'),
                  icon: pageindex == 3
                      ? Icon(
                          Icons.settings,
                          color: MyColors.mainColor,
                        )
                      : Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                  onTap: () {
                    setState(() {
                      pageindex = 3;
                    });
                  }),
            ],
          ),
        ));
  }
}
