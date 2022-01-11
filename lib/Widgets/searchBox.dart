

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Store/Search.dart';


class SearchBoxDelegate extends SliverPersistentHeaderDelegate
{
  get data => null;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent
      ) =>
      InkWell(
        onTap: (){
          Clipboard.setData(ClipboardData(text: data));
          HapticFeedback.heavyImpact();

          Route route = MaterialPageRoute(builder: (c)=>SearchProduct());
          Navigator.pushReplacement(context , route);
        },
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.black54,Colors.grey],
              begin: const FractionalOffset(0.0,0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            ),

          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 60.0,//new50
          child: InkWell(
            child: Container(
             margin: EdgeInsets.only(left: 3.0,right: 3.0),
              width: MediaQuery.of(context).size.width,
              height: 70.0,//new 50
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("search here",style: TextStyle(color: Colors.amber),),

                  ),
                ],
              ),

            ),
          ),
        ),
      );



  @override
  double get maxExtent => 40;

  @override
  double get minExtent =>40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}


