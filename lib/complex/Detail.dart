import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Detail extends StatefulWidget {  // Todo를 들고 있을 필드를 선언합니다.
  final DocumentSnapshot dc;
  Detail({ required this.dc}) ;
  @override
  _DetailState createState() => _DetailState();
}


class _DetailState extends State<Detail>{

  final TextEditingController placeCtr=TextEditingController();
  final TextEditingController contentCtr=TextEditingController();
  // 생성자 매개변수로 Todo를 받도록 강제합니다.


  @override
  Widget build(BuildContext context) {
    // UI를 그리기 위해 Todo를 사용합니다.
    String a="";
    placeCtr.text=widget.dc['place'];
    contentCtr.text=widget.dc['content'];


    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child:Column(
          children: [TextField(
            controller: placeCtr,

            decoration: InputDecoration(
              labelText: widget.dc['place'],

              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: contentCtr,

            decoration: InputDecoration(
              labelText: widget.dc['content'],
              border: OutlineInputBorder(),
            ),
          ),
          RaisedButton(
            child:Text("tctr 값 넣어보기"),
            onPressed: (){
              print("tctr 값 바꾸기");
                setState(() {
                  contentCtr.text="tctr 값 바꾸기";
                });
            },
          ),
          RaisedButton(
            child: Text("수정"),
            onPressed: (){
              FirebaseFirestore.instance.collection("ourlist").doc(widget.dc.id).update({'content':contentCtr.text, 'place':placeCtr.text});
              Navigator.pop(context);
            },
          )],
        ),

      ),
    );
  }


}