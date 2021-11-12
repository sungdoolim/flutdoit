
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [_buildTop(context), _buildMiddle(context), _buildBottom(context)],
    );
  }

  Widget _buildTop(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            // 이럴꺼면 밑에 칼럼을 왜씀..?
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 고르게 퍼트리자
            children: [
              InkWell(
                onTap: () { makeSnac2("스낵1",context);},
                child: Column(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {makeSnac2("스낵2",context);},
                child: Column(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 고르게 퍼트리자
            children: [
              InkWell(
                onTap: () {makeSnac2("스낵3",context);},
                child: Column(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {makeSnac2("스낵4",context);},
                child: Column(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                ],
              ),
              Opacity(
                opacity: 0.0, // 투명 숨기기!
                child: Column(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMiddle(context) {
    return CarouselSlider(

      options: CarouselOptions(height: 150.0,autoPlay: true),
      items: ["res/img/iu1.jpg", "res/img/iu2.jpg", "res/img/iu3.jpg"].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: (){
                makeSnac2(i, context);
              },
              child: ClipRRect(

                /*width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.amber
                  ),  -- Container일때 */
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(i,fit: BoxFit.cover,),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildBottom(context) {
    final items=List.generate(5,(i){
      return ListTile(
        onTap: (){
          makeSnac2(i.toString(),context);
        },
        leading:Icon(Icons.notifications_none),
        title:Text("notif none"),
      );

    });


    return ListView(
    physics: NeverScrollableScrollPhysics(),// 스크롤 중지
    shrinkWrap: true,// 리스트가 다른 스크롤 미에 있으면 반드시 있어야한다.
    children: items,
    );

  }

  SnackBar makeSnac(snacstr){
    final snac = SnackBar(
      content: Text(snacstr), //response.body / statusCode
      action: SnackBarAction(
        label: "cancel",
        onPressed: () {
          print("취소");
        },
      ),
    );
    return snac;
  }


  void makeSnac2(snacstr,context){
    final snac = SnackBar(
      content: Text(snacstr), //response.body / statusCode
      action: SnackBarAction(
        label: "cancel",
        onPressed: () {
          print("취소");
        },
      ),
    );
    Scaffold.of(context).showSnackBar(makeSnac(snacstr));
  }




}
