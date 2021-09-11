import 'package:first_app/helper/constants.dart';
import 'package:first_app/services/database.dart';
import 'package:first_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  const ConversationScreen({ Key? key, required this.chatRoomId }) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethod databaseMethod = new DatabaseMethod();
  TextEditingController messagecontroller = new TextEditingController();
  // Widget ChatMessageList(){

  // }
  sendMessage(){
    if(messagecontroller.text.isNotEmpty){
    Map<String,String> messageMap={
      "message":messagecontroller.text,
      "sendby": Constant.myName
    };
    databaseMethod.getConversationMessge(widget.chatRoomId, messageMap);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: Color(0x54ffffff),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: messagecontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Message...",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      )),
                      GestureDetector(
                        onTap: () {
                          // initiateSearch();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF)
                              ]),
                              borderRadius: BorderRadius.circular(40)),
                          child: Image.asset("assets/images/send.png"),
                        ),
                      )
                    ],
                  ),
                ),
            ),
            
          ],
        ),
      ),
    );
  }
}