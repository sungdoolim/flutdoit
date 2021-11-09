import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doitf/second_page.dart';
import 'package:doitf/state_main.dart';
import 'package:doitf/third.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

import 'fifth.dart';
import 'forth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyHomePage createState()=>MyHomePage();
  // This widget is the root of your application.




}

class MyHomePage extends State<MyApp> {
  var title="title";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Builder(builder: (context) {
        return Center(
            child: Column(
          children: [
            Row(
              children: [
                RaisedButton(
                  child: Text("third"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => ThirdPage()));
                  },
                ),
                RaisedButton(
                  child: Text("forth"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => ForthPage()));
                  },
                ),
                RaisedButton(
                  child: Text("fifth"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => FifthPage()));
                  },
                )
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  child: Text("second page"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text("switch/ chkbox"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StateMain()),
                    );
                  },
                ),
                RaisedButton(
                    child: Text("alert"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("alert!"),
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                children: [Text("alert"), Text("dialog")],
                              ),
                            ),
                            actions: [
                              FlatButton(
                                child: Text("ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  child: Text("http"),
                  onPressed: () async {
                    String url="https://staris.loca.lt/web/androidtest.do";
                  //  var response=await http.get(url);
                    var response=await http.post(url,body:{"id":"flutter","pw":"플루토"} );
                    // post로 값 보내기 가능
                    print(response.body);// parse 안한거
                    Map<String,dynamic> data=jsonDecode(response.body);

                    print(data['SendData']);
                    print(data['SendData'][0]["l"]);


                    final snac = SnackBar(
                      content: Text(response.toString()), //response.body / statusCode
                      action: SnackBarAction(
                        label: "cancel",
                        onPressed: () {
                            print("취소");
                        },
                      ),
                    );

                    Scaffold.of(context).showSnackBar(snac);
                  },
                )
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  child: Text("fireread"),
                  onPressed: fireread,
                ),
                RaisedButton(
                  child: Text("fireadd"),
                  onPressed: fireadd,
                ),
                RaisedButton(
                  child: Text("fireupdate"),
                  onPressed: fireupdate,
                ),
                RaisedButton(
                  child: Text("firedel"),
                  onPressed: firedel,
                ),
              ],
            ),
            GestureDetector(
              child: Text("snackbar / gdetec"),
              onTap: () {
                print("gd");
                final snac = SnackBar(
                  content: Text("gdectoryy???"),
                  action: SnackBarAction(
                    label: "cancel",
                    onPressed: () {
                      //  print("취소");
                    },
                  ),
                );

                Scaffold.of(context).showSnackBar(snac);
              },
            ),
            InkWell(
                child: Text("inkwell/toast"),
                onTap: () {
                  print("ink");
                  final snac = SnackBar(
                    content: Text("inkwell???"),
                    action: SnackBarAction(
                      label: "cancel",
                      onPressed: () {
                        //  print("취소");
                      },
                    ),
                  );

                  Scaffold.of(context).showSnackBar(snac);
                })
          ],
        ));
      }),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("home"),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text("person")),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), title: Text("notif")),
      ]),
    )
    );
  }
  void fireadd(){
    FirebaseFirestore.instance
        .collection('fsample')
        .add({'title':"testtitle",'content':"testContent"});
  }
  void fireread(){
    FirebaseFirestore.instance
        .collection('fsample')
        .doc('2wJBmKGWKRwvTmjSbKFF')
        .get()
        .then((doc) {
          print(title);
          setState(() {

            title=doc.get('title');
          });
          print(title);
      print(doc.get('title'));
      print(doc.get('content'));
    });
  }
  void fireupdate(){
    FirebaseFirestore.instance
        .collection('fsample')
        .doc('2wJBmKGWKRwvTmjSbKFF')
        .update({'title':'updatetitle'});

  }
  void firedel(){
    FirebaseFirestore.instance
        .collection('fsample')
        .doc("2wJBmKGWKRwvTmjSbKFF")
        .delete();
  }
}
