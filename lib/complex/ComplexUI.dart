//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'Page1.dart';
import 'Page2.dart';
import 'Page3.dart';

import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ComplexUI());
}

class ComplexUI extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flut complex',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 1;
  var _pages = [Page3(1),Page3(-1),Page3(0)];
 // final FirebaseMessaging fcm=FirebaseMessaging();


  @override
  void initState() {
    fcmTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("❤loveList💖", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Page1(),
                  ),
                );
              });
            },
          )
        ],
      ),
      body: Builder(builder: (context){
        return _pages[_index];
    }),


      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: [

          BottomNavigationBarItem(
               icon: Icon(Icons.account_circle),label:"Ck"),
          BottomNavigationBarItem(
               icon: Icon(Icons.account_circle),label:"nonCk"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),label:"allCk"),
        ],
      ),
    );
  }
void fcmTest(){
    // fcm.configure(
    //     onMessage: (Map<String, dynamic> message) async {
    //       print("onMessage: $message");
    //     },
    //     onResume: (Map<String, dynamic> message) async {
    //       print("onResume: $message");
    //     },
    //     onLaunch: (Map<String, dynamic> message) async {
    //       print("onLaunch: $message");
    //     }
    // );
    // fcm.getToken().then((String token){
    //   print('token : $token');
    // });
  }
}
