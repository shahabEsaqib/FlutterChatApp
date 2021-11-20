
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<QuerySnapshot>? chatMessageStream;
  Widget chatMessageList(){
    return StreamBuilder<QuerySnapshot>(
      stream: chatMessageStream,
      builder: (context,snapshot){
        return snapshot.hasData? ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            return MessageTile(message :snapshot.data!.docs[index]["message"],
             isSendByMe: snapshot.data!.docs[index]["sendby"]== Constant.myName,
            
            );
          } 
          
          ):Container();
      });
  }
  sendMessage(){
    if(messagecontroller.text.isNotEmpty){
    Map<String,dynamic> messageMap={
      "message":messagecontroller.text,
      "sendby": Constant.myName,
      "time": DateTime.now().microsecondsSinceEpoch
    };
    databaseMethod.addConversationMessage(widget.chatRoomId, messageMap);
    messagecontroller.text = "";
    }
    
  }
  @override
  void initState() {
    databaseMethod.getConversationMessage(widget.chatRoomId).then((value){
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            chatMessageList(),
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
                          sendMessage();
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
class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  const MessageTile({ Key? key, required this.message, required this.isSendByMe }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: isSendByMe ? 0 : 24,
          right: isSendByMe ? 24 : 0),
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
         margin: isSendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: isSendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
        topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: isSendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ]
                  : [
                const Color(0x1AFFFFFF),
                const Color(0x1AFFFFFF)
              ],
            )
        ),
        child: Text(message,style: simpleTextStyle(),),
      ),
    );
  }
}