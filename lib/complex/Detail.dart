import 'dart:math';

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

  // 생성자 매개변수로 Todo를 받도록 강제합니다.

  final TextEditingController placeCtr=TextEditingController();
  final TextEditingController contentCtr=TextEditingController();
  var isChecked;
  var idx;


  @override
  void initState() {

    placeCtr.text=widget.dc['place'];
    contentCtr.text=widget.dc['content'];
    isChecked=widget.dc['ischecked'];
  }

  @override
  Widget build(BuildContext context) {
    // UI를 그리기 위해 Todo를 사용합니다.
    String a="";

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
          Row(
            children: [
              Text("완료! : "),
              Checkbox(
                value : isChecked,
                onChanged:(value){
                  setState(() {
                    isChecked=value;
                  });
                }
              )
            ],
          ),
          Row(
            children: [
              RaisedButton(
                child:Text("삭제하나요오오오오"),
                onPressed: (){
                  deleteFstore();
                },
              ),
              RaisedButton(
                child: Text("수정"),
                onPressed: (){
                  if(isChecked!=widget.dc["ischecked"]){
                    var fist=FirebaseFirestore.instance.collection("ourlist").orderBy("index",descending:true).limit(1).get();
                    fist.then((k){
                      idx=k.docs.first.get("index");
                      updateFstore();
                    });
                  }else{
                    updateFstore();
                  }
                  Navigator.pop(context);// 뒤로 가기
                },
              )
            ],
          )

          ],
        ),

      ),
    );
  }
  void updateFstore(){
    FirebaseFirestore.instance.collection("ourlist").doc(widget.dc.id).update(
        { 'content':contentCtr.text,
          'place':placeCtr.text,
          'ischecked':isChecked,
        }
    );
  }
  void deleteFstore(){
      FirebaseFirestore.instance.collection("ourlist").doc(widget.dc.id).delete();
      Navigator.pop(context);// 뒤로 가기
  }


}