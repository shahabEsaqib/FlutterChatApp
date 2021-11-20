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

  createChatRoom(String charRoomId ,chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(charRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
  addConversationMessage(String chatRoomId , messageMap ){
  FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chats").add(messageMap).catchError((e){
  print(e.toString());
  });
  }

  getConversationMessage(String chatRoomId) async{
  return await FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chats").orderBy("time", descending: false).snapshots();
  }
  getChatRooms(String userName)async{
    return await FirebaseFirestore.instance.collection("ChatRoom").where("user", arrayContains: userName).snapshots();
  }

}
