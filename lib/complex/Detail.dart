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

      body: Column(
        children: [
          SizedBox(
          width: 150,
          height: 50
        ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child:Column(
              children: [
                TextField(
                controller: placeCtr,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,

                decoration: InputDecoration(
                  labelText: "장소를 적어주세여 ",

                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height:50
              ),
              TextField(
                controller: contentCtr,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: "머 할꺼에여?? 머 먹나여?????",
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
                          idx=k.docs.first.get("index")+1;
                          updateFstore();
                        });
                      }else{
                        idx=widget.dc['index'];
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
        ],
      ),
    );
  }
  void updateFstore(){
    FirebaseFirestore.instance.collection("ourlist").doc(widget.dc.id).update(
        { 'content':contentCtr.text,
          'place':placeCtr.text,
          'ischecked':isChecked,
          'index':idx
        }
    );
  }
  void deleteFstore(){
    var delck=false;
    var k=showDialog(
      context: context,

      builder: (BuildContext context) {

        return AlertDialog(
          title: Text("지워???"),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [Text("왜지우까~"), Text("알수가 옴내에에ㅔ")],
            ),
          ),
          actions: [
            FlatButton(
              child: Text("진짜 지운댜????"),
              onPressed: () {
                delck=true;
                FirebaseFirestore.instance.collection("ourlist").doc(widget.dc.id).delete();
                Navigator.pop(context);// 뒤로 가기
              },
            ),
            FlatButton(
              child: Text("안지울랭~"),
              onPressed: () {
                Navigator.pop(context);// 뒤로 가기
              },
            ),
          ],
        );
      },
    ).then((value){
      print(delck);

      Navigator.pop(context);
    });

  }

}