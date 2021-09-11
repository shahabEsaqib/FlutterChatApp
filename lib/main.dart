// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/helper/autinticate.dart';
import 'package:first_app/helper/helperfunction.dart';
import 'package:first_app/views/chatScreen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isloggedIn = false;
  
  @override
  void initState() {    
    getLoggedInState();
    super.initState();
  }
  getLoggedInState()async{
    await HelperFunction.getUserLoggedInSharedPrefrece().then((value) { 
      setState(() {
        isloggedIn = value!;  
      });      
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff),
        primarySwatch: Colors.blue,
      ),
      home: isloggedIn? ChatRoom():Authenticate()
    );
  }
}
class Iamblank extends StatefulWidget {
  @override
  _IamblankState createState() => _IamblankState();
}

class _IamblankState extends State<Iamblank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
