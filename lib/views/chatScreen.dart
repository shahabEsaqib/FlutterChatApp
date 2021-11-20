
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/helper/autinticate.dart';
import 'package:first_app/helper/constants.dart';
import 'package:first_app/helper/helperfunction.dart';
import 'package:first_app/services/auth.dart';
import 'package:first_app/services/database.dart';
import 'package:first_app/views/conversationScreen.dart';
import 'package:first_app/views/search.dart';
import 'package:first_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethod authMethod = new AuthMethod();
  DatabaseMethod databaseMethod = new DatabaseMethod();
  Stream<QuerySnapshot>? chatRoomStream;
  
  Widget chatRoomList(){
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomStream,
      builder: (context,snapshot){
        return snapshot.hasData? ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            return ChatRoomList(userName: snapshot.data!.docs[index]["chatRoomId"]
            .toString().replaceAll("_", "").replaceAll(Constant.myName, ""),
            chatRoomId: snapshot.data!.docs[index]["chatRoomId"]
            );
          }):Container();

      }
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }


  getUserInfo()async{
    // ignore: await_only_futures
    Constant.myName= await HelperFunction.getUserLoggedInSharedPrefrece().toString();
    databaseMethod.getChatRooms(Constant.myName).then((value){
      setState(() {
        chatRoomStream=value;
      });
    });
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 60,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              authMethod.signOut();

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}

class ChatRoomList extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  const ChatRoomList({ Key? key, required this.userName, required this.chatRoomId }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationScreen(chatRoomId: chatRoomId)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        color: Colors.blue,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:BorderRadius.circular(40)
              ),
              child: Text("${userName.substring(0,1).toUpperCase()}"),
            ),
            SizedBox(width: 8,),
            Text(userName,style: mediumTextStyle(),)
            
          ],
        ),
      ),
    );
  }
}