import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/helper/helperfunction.dart';
import 'package:first_app/services/auth.dart';
import 'package:first_app/services/database.dart';
import 'package:flutter/material.dart';

import 'package:first_app/widgets/widgets.dart';

import 'chatScreen.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  const SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  AuthMethod authMethod = new AuthMethod();
  DatabaseMethod databaseMethod = new DatabaseMethod();
  
  bool isLooding = false;
  QuerySnapshot? snapshotUserInfo;
  signIn(){
    if(formkey.currentState!.validate()){

      HelperFunction.saveUserEmailSharedPrefrece(emailTextEditingController.text);
      
      setState(() {
        isLooding=true;
      });
      databaseMethod.getUserByUserEmail(emailTextEditingController.text).then((val){
        snapshotUserInfo = val;
        HelperFunction.saveUserEmailSharedPrefrece(snapshotUserInfo!.docs[0]["name"]);
      });
      authMethod.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((value) {
        if(value != null){
          HelperFunction.saveUserLoggedInSharedPrefrece(true);
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatRoom()));

        }
      });
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
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
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "please provide a valid emailid";
                            },
                      controller: emailTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("email"),
                    ),
                  ],
                ),
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
                decoration: textFieldInputDecoration("password"),
              ),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  "forgot Password?",
                  style: simpleTextStyle(),
                ),
              ),
              SizedBox(height: 16),
              Container(
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
                  "Sign In",
                  style: mediumTextStyle(),
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
                  "Sign In with Google",
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
                    "don't have account? ",
                    style: mediumTextStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Ragister now",
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
