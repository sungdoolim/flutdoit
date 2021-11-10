import 'package:flutter/material.dart';

class Page1 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("홈 페이지", style:TextStyle(fontSize:40))
    );
  }
}
class Page2 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("이용 서비스", style:TextStyle(fontSize:40))
    );
  }
}
class Page3 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("내정보", style:TextStyle(fontSize:40))
    );
  }
}