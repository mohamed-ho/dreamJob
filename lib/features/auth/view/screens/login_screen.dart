import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dreamjob/core/constants/string.dart';
import 'package:dreamjob/core/widgets/custem_Button.dart';
import 'package:dreamjob/core/widgets/custom_Error_dialog.dart';
import 'package:dreamjob/features/Home/view/screens/control_screen.dart';
import 'package:dreamjob/features/Home/view/screens/home_screen.dart';
import 'package:dreamjob/features/auth/data/data_surce/firbase_data_surce.dart';
import 'package:dreamjob/features/auth/view/screens/signup_screen.dart';
import 'package:dreamjob/features/auth/view/widgets/custom_Icon_Button.dart';
import 'package:dreamjob/features/auth/view/widgets/auth_password_textFomField.dart';
import 'package:dreamjob/features/auth/view/widgets/auth_textFormField.dart';
import 'package:dreamjob/features/company/Home/screens/control_company_screen.dart';
import 'package:dreamjob/features/company/data/Data_source/job_data_source.dart';
import 'package:dreamjob/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String id = 'login_screen';
  bool progressHud = false;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  String email = '';

  String password = '';

  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isJobOwner = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      body: ModalProgressHUD(
        opacity: .3,
        inAsyncCall: widget.progressHud,
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 99, left: 30, bottom: 9),
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, bottom: 30, right: 148),
                child: Text('Fill your details or continue with social media',
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
                child: AuthTextFormField(
                  hintText: 'email',
                  icon: const Icon(Icons.email_outlined),
                  onchanged: (value) {
                    email = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 9),
                child: AuthPasswordTextFormField(
                  hintText: 'password',
                  onChange: (value) {
                    password = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, left: 310),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 39),
                child: CustomButton(
                    onpressed: () async {
                      if (globalKey.currentState!.validate()) {
                        try {
                          //dismiss keyboard during async call
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            widget.progressHud = true;
                          });
                          if (isJobOwner) {
                            await AuthFirebaseDataSurce()
                                .signInAsJobOwner(email, password, context);
                          } else {
                            await AuthFirebaseDataSurce()
                                .signInAsWorker(email, password, context);
                          }
                          setState(() {
                            widget.progressHud = false;
                          });
                        } catch (e) {
                          setState(() {
                            widget.progressHud = false;
                          });
                        }
                      }
                    },
                    textChild: 'LOG IN'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 29),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or Continue with',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 30,
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    iconPath: 'assets/images/Google.png',
                    onpressed: () {},
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomIconButton(
                      iconPath: 'assets/images/Facebook.png', onpressed: () {})
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 120),
                child: TextButton(
                  child: Text('New User? Create Account'),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(SignUPScreen.id, arguments: isJobOwner);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
