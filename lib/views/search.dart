// import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/helper/constants.dart';
import 'package:first_app/views/conversationScreen.dart';
import 'package:flutter/material.dart';

import 'package:first_app/services/database.dart';
import 'package:first_app/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, searchsnapshot}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethod databaseMethod = new DatabaseMethod();
  TextEditingController searchTextEditingController =
      new TextEditingController();

  QuerySnapshot? searchsnapshot;

  initiateSearch() {
    databaseMethod
        .getUserByUserName(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchsnapshot = val;
      });
    });
  }

  creatChatRoomAndStartConversation({String? username}){
    print("helllllllllllllllo ${Constant.myName}");
    if(username != Constant.myName){
      String chatRoomId = getChatRoomId(username!, Constant.myName);
    List<String> users = [username ,Constant.myName];
    Map<String,dynamic> chatRoomMap={
      "users": users,
      "chatRoomId":chatRoomId
    };
    DatabaseMethod().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationScreen(chatRoomId: chatRoomId,)));
    }else{
      print("you can not send messege to yourself");
    }
  }

  Widget searchList() {
    // ignore: unnecessary_null_comparison
    return searchsnapshot != null
        ? ListView.builder(
            itemCount: searchsnapshot!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                  
                username: searchsnapshot!.docs[index]['name'],
                useremail: searchsnapshot!.docs[index]["email"],
              );
            })
        : Container(
          height: MediaQuery.of(context).size.height*0.75,
          alignment: Alignment.bottomCenter,
          child: Center(child: Text("Search by username",style: TextStyle(color: Colors.white),)),
        );
  }

  Widget searchTile({String? username, String? useremail}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Text(
                username!,
                style: mediumTextStyle(),
              ),
              Text(
                useremail!,
                style: mediumTextStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              // ignore: unnecessary_statements
              creatChatRoomAndStartConversation(username: username);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Message",style: mediumTextStyle(),),
            ),
          )
        ],
      ),
    );
  
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    // initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0x54ffffff),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        initiateSearch();
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
                        child: Image.asset("assets/images/search_white.png"),
                      ),
                    )
                  ],
                ),
              ),
              searchList(),
            ],
          ),
        ),
      ),
    );
  }
}



