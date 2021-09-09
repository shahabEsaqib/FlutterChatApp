import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String sharedPrefrenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefrenceUserNameKey = "USERNAMEKEY";
  static String sharedPrefrenceUserEmailKey = "USEREMAILKEY";
  //saving data to shared Prefrences
  static Future<bool> saveUserLoggedInSharedPrefrece(bool isUserloggedIn)async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPrefrenceUserLoggedInKey, isUserloggedIn);
  }

  static Future<bool> saveUserNameSharedPrefrece(String username)async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefrenceUserNameKey, username);
  }

  static Future<bool> saveUserEmailSharedPrefrece(String useremail)async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefrenceUserEmailKey, useremail);
  }

   //getting data from shared Prefrences
  static Future<bool?> getUserLoggedInSharedPrefrece()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    
    return prefs.getBool(sharedPrefrenceUserLoggedInKey);
  }

  static Future<String?> getUserNameSharedPrefrece()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefrenceUserNameKey);
  }

  static Future<String?> getUserEmailSharedPrefrece()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefrenceUserEmailKey);
  }


}