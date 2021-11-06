import 'package:flutter/material.dart';

import 'forth.dart';
import 'main.dart';

void main() {
  runApp(const ThirdPage());
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Third(),
    );
  }
}

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('제목'),
      ),
      body:ListView(
        scrollDirection: Axis.vertical,
        children: [
          ListTile(
            leading:Icon(Icons.home),
            title:Text("main"),
            trailing:Icon(Icons.navigate_next),
            onTap:(){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>MyApp()));
            }
          ),
          ListTile(
              leading:Icon(Icons.home),
              title:Text("forth"),
              trailing:Icon(Icons.navigate_next),
              onTap:(){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>ForthPage()));
              }
          ),

        ],
      )
    );
  }



}
