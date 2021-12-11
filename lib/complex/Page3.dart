import 'package:flutter/material.dart';

import 'TodoListPage.dart';


class Page3 extends StatelessWidget{
  final int v;
  Page3(this.v);
  @override
  Widget build(BuildContext context) {
    return TodoListPage(v);
  }
}

