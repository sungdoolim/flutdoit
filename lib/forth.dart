import 'package:doitf/fifth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  runApp(const ForthPage());
}

class ForthPage extends StatelessWidget {
  const ForthPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Forth(),
    );
  }
}

class Forth extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('제목'),
      ),
      body:GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
              color:Colors.red,
              child:RaisedButton(
                child:Text("main"),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                },
              )
          ),
          Container(
              color:Colors.yellow,
              child:RaisedButton(
                child:Text("main"),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                },
              )
          ),
          Container(
              color:Colors.blue,
              child:RaisedButton(
                child:Text("fifth"),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FifthPage()));
                },
              )
          ),
        ],
      )
    );
  }



}
