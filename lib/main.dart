import 'dart:convert';

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('제목'),
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
    );
  }
}
