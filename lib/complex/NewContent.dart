import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TodoListPage.dart';



class NewContent extends StatefulWidget {  // Todo를 들고 있을 필드를 선언합니다.
  @override
  _NewContentState createState() => _NewContentState();
}


class _NewContentState extends State<NewContent>{

  // 생성자 매개변수로 Todo를 받도록 강제합니다.

  final TextEditingController placeCtr=TextEditingController();
  final TextEditingController contentCtr=TextEditingController();
  var isChecked;
  var idx;

  @override
  Widget build(BuildContext context) {
    // UI를 그리기 위해 Todo를 사용합니다.

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child:Column(
          children: [TextField(
            controller: placeCtr,

            decoration: InputDecoration(
              labelText: "어디서??",

              border: OutlineInputBorder(),
            ),
          ),
            TextField(
              controller: contentCtr,

              decoration: InputDecoration(
                labelText: "뭐해???????",
                border: OutlineInputBorder(),
              ),
            ),

            RaisedButton(
              child: Text("수정"),
              onPressed: (){
                insertFstore();
                Navigator.pop(context);// 뒤로 가기
              },
            )

          ],
        ),

      ),
    );
  }
  void insertFstore(){
    var fist=FirebaseFirestore.instance.collection("ourlist").orderBy("index",descending:true).limit(1).get();
    fist.then((k){
      idx=k.docs.first.get("index");
      FirebaseFirestore.instance.collection("ourlist").add(
          {"place":placeCtr.text, "content": contentCtr.text, "ischecked": false, "index": idx+1,"due":null,
            "id":TodoListPage.modelNm=="SM-G981N" ? "내꿍" : "누꿍",
            "rest":0,"url":""});
    });


  }


}