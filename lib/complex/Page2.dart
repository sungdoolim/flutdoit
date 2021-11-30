import 'package:flutter/material.dart';
class Page2 extends StatelessWidget{
  final TextEditingController txController1=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        TextField(
          controller: txController1,
      ),
      
      RaisedButton(
        child: Text("log"),
        onPressed: (){log();},
      )],
    );
  }

  void log(){
    print(txController1.text);
  }
}
