import 'package:doitf/third.dart';
import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  runApp(const SecondPage());
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Second(),
    );
  }
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar:AppBar(
          title:Text('제목'),
        ),
        body:Column(
          children: [
            Container(
              color:Colors.amber,
              width:100,
              height:100,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child:Text("btn_go_main"),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context)=>MyApp()
                      )
                  );
                },
              ),
            ),
            RaisedButton(
              child:Text("third page"),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Third()));
              },
            ),
            Card(
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 10.0,
              child:Container(
                width:200,
                height:200,
                color:Colors.amber
              )
            ),
            CircularProgressIndicator(),
            LinearProgressIndicator(),
            TextField(
              decoration: InputDecoration(
                labelText:'hint입니다',
                border:OutlineInputBorder(),
              ),

            ),


          ],
        ),
    );
  }



}
