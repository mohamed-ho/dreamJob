import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dreamjob/core/widgets/custem_Button.dart';
import 'package:dreamjob/core/widgets/custom_Error_dialog.dart';
import 'package:dreamjob/features/auth/data/data_surce/firbase_data_surce.dart';
import 'package:dreamjob/features/auth/view/widgets/custom_Icon_Button.dart';
import 'package:dreamjob/features/auth/view/widgets/auth_password_textFomField.dart';
import 'package:dreamjob/features/auth/view/widgets/auth_textFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUPScreen extends StatefulWidget {
  SignUPScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  String userName = '';

  String email = '';

  String password = '';

  bool isJobOwner = true;

  GlobalKey<FormState> globalKey = GlobalKey();

  bool progresshud = false;

  TextEditingController useNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    isJobOwner = ModalRoute.of(context)!.settings.arguments as bool;
    return ModalProgressHUD(
      inAsyncCall: progresshud,
      child: Scaffold(
        body: Form(
          key: globalKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 30, bottom: 38),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: (() {
                        Navigator.of(context).pop();
                      }),
                      icon: Icon(Icons.arrow_back_ios)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Register Account',
                  style: TextStyle(
                    fontSize: 30,
                  ),
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
                  controller: useNameController,
                  hintText: isJobOwner ? 'Company Name' : 'user Name',
                  icon: isJobOwner
                      ? const Icon(Icons.assured_workload)
                      : const Icon(Icons.person),
                  onchanged: (value) {
                    userName = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
                child: AuthTextFormField(
                  controller: emailController,
                  hintText: 'Email Address',
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
                  controller: passwordController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 39),
                child: CustomButton(
                    onpressed: () async {
                      try {
                        if (globalKey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            progresshud = true;
                          });
                          if (isJobOwner)
                            await AuthFirebaseDataSurce().signUpAsJobOwner(
                                email, password, userName, context);
                          else
                            await AuthFirebaseDataSurce().signUpAsWorker(
                                email, password, userName, context);

                          setState(() {
                            progresshud = false;
                            useNameController.text = '';
                            emailController.text = '';
                            passwordController.text = '';
                          });
                        }
                      } catch (e) {
                        setState(() {
                          progresshud = false;
                        });
                        CustomErrorDialog(context, e.toString(), e.toString());
                      }
                    },
                    textChild: 'SIGN UP'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 29),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      child: const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or Continue with',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 30,
                      child: const Divider(
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
                  const SizedBox(
                    width: 20,
                  ),
                  CustomIconButton(
                      iconPath: 'assets/images/Facebook.png', onpressed: () {})
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 110),
                child: TextButton(
                  child: const Text('Already Have Account? Log In'),
                  onPressed: () {
                    Navigator.of(context).pop();
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
