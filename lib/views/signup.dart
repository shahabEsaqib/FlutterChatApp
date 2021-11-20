import 'package:first_app/helper/helperfunction.dart';
import 'package:first_app/services/database.dart';
import 'package:flutter/material.dart';

import 'package:first_app/services/auth.dart';
import 'package:first_app/views/chatScreen.dart';
import 'package:first_app/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  const SignUp({
    Key? key,
    required this.toggle,
  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  AuthMethod authMethod = new AuthMethod();
  DatabaseMethod databaseMethod = new DatabaseMethod();
  
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
      
  bool isLoading = false;

  signMeUp() {
    if (formkey.currentState!.validate()) {
      Map<String, String> userInfoMap = {
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text
      };
      HelperFunction.saveUserEmailSharedPrefrece(emailTextEditingController.text);
      HelperFunction.saveUserNameSharedPrefrece(userNameTextEditingController.text);
      setState(() {
        isLoading = true;
      });

      authMethod
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        print("${val.uid}");
      });

      databaseMethod.uploadUserInfo(userInfoMap);
      HelperFunction.saveUserLoggedInSharedPrefrece(true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatRoom()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty || val.length < 2
                                  ? "please provide a valid username"
                                  : null;
                            },
                            controller: userNameTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("User Name"),
                          ),
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "please provide a valid emailid";
                            },
                            controller: emailTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("Email"),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val!.length > 6
                                  ? null
                                  : "please provide password 6+ character";
                            },
                            controller: passwordTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("Password"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      alignment: Alignment.centerRight,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        "forgot Password?",
                        style: simpleTextStyle(),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        signMeUp();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Sign Up",
                          style: mediumTextStyle(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Sign Up with Google",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account? ",
                          style: mediumTextStyle(),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "SignIn now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
