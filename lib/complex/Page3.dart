import 'package:flutter/material.dart';

import 'TodoListPage.dart';


class Page3 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"할일 관리",
      theme : ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:TodoListPage(),
    );
  }
}

