import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'Detail.dart';
import 'NewContent.dart';
import 'Todo.dart';
import 'package:device_info/device_info.dart';

class TodoListPage extends StatefulWidget {

  static String modelNm="";

  int v;   // 0 , 1, -1

  TodoListPage(this.v);
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _items = <Todo>[];


  List _data=<dynamic>[];
  var _todoController = TextEditingController();
  var _todoController2 = TextEditingController();
  var ck = false;


  @override
  void initState() {
    getDeviceInfo();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
/*                  Expanded(
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        labelText: "place",
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _todoController2,
                      decoration: InputDecoration(
                        labelText: "content",
                      ),
                    ),
                  ),*/
                  RaisedButton(
                    child: Text('추가'),
                    onPressed: () {
                      _addTodo(Todo(_todoController.text, _todoController2.text,
                          ischecked: false));
                    },
                  ),

/*                  RaisedButton(
                    child: Text('check'),
                    onPressed: () {
                      setState(() {
                        ck = !ck;
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text('get device info'),
                    onPressed: () {
                      print(_data[0]);
                      print(TodoListPage.modelNm);

                    },
                  ),*/
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: getStream(),

                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    final documents = snapshot.data!.docs;
                    // print(documents);
                    //  print(documents.toString());

                    // final List<Todo> ar=documents.map((doc)=>_buildItemWidget(doc)).cast<Todo>().toList();
                    //   print(ar.toString());

                    return Expanded(
                      child: isCheck(ck, documents),
                    );
                  }
              ),
            ]),
          );
        }
      ),
    );
  }


  @override
  void dispose() {
    _todoController.dispose();
    _todoController2.dispose();
  }


  Stream<QuerySnapshot> getStream(){
    if(widget.v==0){
      return  FirebaseFirestore.instance.
      collection('ourlist').
      orderBy('index', descending: true).
      snapshots();
    }else if(widget.v==1){
      return  FirebaseFirestore.instance.
      collection('ourlist').
      where('ischecked', isEqualTo: true).
      orderBy('index', descending: true).
      snapshots();
    }else{
      return  FirebaseFirestore.instance.
      collection('ourlist').
      where('ischecked', isEqualTo: false).
      orderBy('index', descending: true).
      snapshots();
    }

  }
  ListView isCheck(bool ck, List documents) {
    return ListView(

      children: documents.map((doc) => _buildItemWidget(doc)).toList(),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot dc) {
    final todo = Todo(dc['place'], dc['content'], ischecked: dc['ischecked']);
    todo.index = dc['index'];
  //  print(todo.ischecked);

    return ListTile(
      onTap: () => navToDetail(dc), //_toggleTodo(dc),
      // onTap: () =>_toggleTodo(todo_tmp),
      title: Text(
        "어디서         : "+todo.place + " \n 머 먹으까? : " + todo.content + " \n "+todo.index.toString(),
        style: dc['id']=="내꿍"
            ? TextStyle(
          color:Colors.lightBlue,
          fontStyle: FontStyle.italic,
        )
            : TextStyle(
          color:Colors.orange,
          fontStyle: FontStyle.italic,
        ), // 3항 연산자
      ),
      trailing: IconButton(
        icon: todo.ischecked? Icon(Icons.check_box_outlined):Icon(Icons.check_box_outline_blank),
        onPressed: () => _deleteTodo(dc),
        //_deleteTodo_tmp(todo),
      ),);
  }

  Widget _buildItemWidget_tmp(Todo todo) {
    return ListTile(
      onTap: () => _toggleTodo_tmp(todo),
      title: Text(
        todo.title,
        style: todo.ischecked
            ? TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
        )
            : null, // 3항 연산자
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo_tmp(todo),
      ),);
  }

  void _addTodo(Todo todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewContent(),
      ),
    );

/*    FirebaseFirestore.instance.collection("ourlist").add(
        {"place": todo.place, "content": todo.content, "ischecked": false});
    _todoController.text = '';
    _todoController2.text = '';*/
  }

  void navToDetail(DocumentSnapshot dc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail(dc: dc),
      ),
    );
  }

  void _addTodo_tmp(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = '';
      _todoController2.text = '';
    });
  }

  void _deleteTodo(DocumentSnapshot dc) {
    //FirebaseFirestore.instance.collection("ourlist").doc(dc.id).delete();
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("메롱..?"),
    )
  );
  }

  void _deleteTodo_tmp(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  void _toggleTodo(DocumentSnapshot dc) {
    FirebaseFirestore.instance.collection("ourlist").doc(dc.id).update(
        {'ischecked': !dc['ischecked']});
    print(dc['ischecked']);
  }

  void _toggleTodo_tmp(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  void getDeviceInfo(){

    DeviceInfoPlugin plugin=DeviceInfoPlugin();
    initPlatform(plugin);
  }
  Future<void> initPlatform(plugin) async {
    if (Platform.isAndroid) {
      setState(() async {
        _data = getAndroidDevice(await plugin.androidInfo);
        TodoListPage.modelNm=_data[0];
      });
    }
    if (Platform.isIOS) {
      setState(() async {
        _data = getIosDevice(await plugin.iosInfo);
        TodoListPage.modelNm=_data[0];
      });
    }
  }
  getAndroidDevice(AndroidDeviceInfo device) {
    return [
      device.model,
      device.version.securityPatch,
      device.version.sdkInt,
      device.version.release,
      device.version.codename,
      device.board,
      device.bootloader,
      device.brand,
      device.device,
      device.display,
      device.fingerprint,
      device.hardware,
      device.host,
      device.id,
      device.manufacturer,
      device.product,
      device.androidId,

    ];
  }
  getIosDevice(IosDeviceInfo device) {
    return [
      device.name,
      device.systemName,
      device.systemVersion,
      device.model,
      device.localizedModel,
      device.identifierForVendor,
    ];
  }


}