import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  runApp(const FifthPage());
}

class FifthPage extends StatelessWidget {
  const FifthPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Fifth(),
    );
  }
}

class Fifth extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar:AppBar(
          title:Text('제목'),
        ),
        body:PageView(
          children: [
            Container(
                color:Colors.red,
                child:RaisedButton(
                  child:Text("1"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                  },
                )
            ),
            Container(
                color:Colors.yellow,
                child:RaisedButton(
                  child:Text("2"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                  },
                )
            ),
            Container(
                color:Colors.blue,
                child:RaisedButton(
                  child:Text("3"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                  },
                )
            ),
          ],
        )
    );
  }



}
