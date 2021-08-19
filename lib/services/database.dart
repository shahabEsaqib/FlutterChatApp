import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  getUserByUserName(String username) {}

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("user").add(userMap);
  }
}
