import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'Todo.dart';

class TodoListPage extends StatefulWidget {

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _items = <Todo>[];
  var _todoController = TextEditingController();
  var _todoController2 = TextEditingController();
  var ck=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text('남은 할 일')
        ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                    labelText:"place",
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _todoController2,
                  decoration: InputDecoration(
                    labelText:"content",
                  ),
                ),
              ),
              RaisedButton(
                child: Text('추가'),
                onPressed: () {
                  _addTodo(Todo(_todoController.text,_todoController2.text, ischecked: false));
                },
              ),
              RaisedButton(
                child:Text('check'),
                onPressed: (){setState(() {
                  ck=!ck;
                });},
              )
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('ourlist').where('ischecked',isEqualTo: ck).snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              final documents = snapshot.data!.docs;
             // print(documents);
            //  print(documents.toString());

             // final List<Todo> ar=documents.map((doc)=>_buildItemWidget(doc)).cast<Todo>().toList();
           //   print(ar.toString());

              return Expanded(
                child: isCheck(ck,documents),
              );

            }
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _todoController.dispose();
    _todoController2.dispose();
  }

  ListView isCheck (bool ck,List documents){


    return ListView(

      children: documents.map((doc)=>_buildItemWidget(doc)).toList(),
    );
  }
  Widget _buildItemWidget(DocumentSnapshot dc) {
    final todo=Todo(dc['place'],dc['content'],ischecked: dc['ischecked']);

  print(todo.place);

    return ListTile(
      onTap: () =>_toggleTodo(dc),
     // onTap: () =>_toggleTodo(todo_tmp),
      title: Text(
        todo.place+" / "+todo.content,
        style: dc['ischecked']
            ? TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
        )
            : null, // 3항 연산자
      ),
      trailing: IconButton(
        icon:Icon(Icons.delete_forever),
        onPressed: ()=>_deleteTodo(dc),
            //_deleteTodo_tmp(todo),
      ),);
  }

  Widget _buildItemWidget_tmp(Todo todo) {
    return ListTile(
        onTap: () =>_toggleTodo_tmp(todo),
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
      icon:Icon(Icons.delete_forever),
      onPressed: ()=>_deleteTodo_tmp(todo),
    ),);
  }

  void _addTodo(Todo todo) {
    FirebaseFirestore.instance.collection("ourlist").add({"place":todo.place,"content":todo.content,"ischecked":false});
    _todoController.text='';
    _todoController2.text='';

  }
  void _addTodo_tmp(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = '';
      _todoController2.text = '';
    });
  }
  void _deleteTodo(DocumentSnapshot dc) {
    FirebaseFirestore.instance.collection("ourlist").doc(dc.id).delete();
  }
  void _deleteTodo_tmp(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  void _toggleTodo(DocumentSnapshot dc) {
    FirebaseFirestore.instance.collection("ourlist").doc(dc.id).update({'ischecked':!dc['ischecked']});
    print(dc['ischecked']);
  }
  void _toggleTodo_tmp(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
}
