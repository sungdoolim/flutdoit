import 'package:doitf/second_page.dart';
import 'package:flutter/material.dart';

enum Gender{man,woman}
class StateMain extends StatefulWidget{

  @override
  _StateMainState createState()=>_StateMainState();
}
class _StateMainState extends State<StateMain>{
  Gender gender=Gender.man;
  var isChecked=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("state!")
      ),
      body:Padding(
        padding:const EdgeInsets.all(8.0),
            child:Center(
              child:Column(
                children: [
                    Checkbox(value: isChecked,
                          onChanged:(value){
                      setState(() {
                        isChecked=value!;
                      });
                 }),
                  SizedBox(
                    height:40
                  ),
                  Switch(
                    value:isChecked,
                    onChanged:(value){
                      setState(() {
                        isChecked=value;
                      });
                    }
                  ),
                  ListTile(
                    title:Text("남"),
                    leading:Radio(
                      value:Gender.man,
                      groupValue:gender,
                      onChanged: (value){
                        setState(() {
                          gender=value as Gender;//casting
                        });
                      },
                    )
                  ),
                  ListTile(
                      title:Text("여"),
                      leading:Radio(
                        value:Gender.woman,
                        groupValue:gender,
                        onChanged: (value){
                          setState(() {
                            gender=value as Gender;//casting
                          });
                        },
                      )
                  ),
                  SizedBox(
                    height:40
                  ),
                  RadioListTile(
                      title:Text("남"),

                        value:Gender.man,
                        groupValue:gender,
                        onChanged: (value){
                          setState(() {
                            gender=value as Gender;//casting
                          });
                        },

                  ),
                  RadioListTile(
                      title:Text("여"),

                        value:Gender.woman,
                        groupValue:gender,
                        onChanged: (value){
                          setState(() {
                            gender=value as Gender;//casting
                          });
                        },

                  ),
                ],
              )
            )
          )

    );
  }
}