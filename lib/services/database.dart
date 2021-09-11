import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  getUserByUserName(String username) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String useremail) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .where("email", isEqualTo: useremail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("user").add(userMap);
  }

  createChatRoom(String chatRoomId ,chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
  getConversationMessge(String chatRoomId , messageMap ){

FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chats").add(messageMap).catchError((e){
  print(e.toString());
});
  }
}
