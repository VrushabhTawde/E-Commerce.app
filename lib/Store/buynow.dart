import 'package:e_shop/Orders/OrderDetailsPage.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';


class BuyNow extends StatefulWidget
{
  final ItemModel itemModel;
  BuyNow({this.itemModel});
  @override
  _BuyNow createState() => _BuyNow();
}



class _BuyNow extends State<BuyNow>
{
  int quantityOfItems=1;
  @override
  Widget build(BuildContext context)
  {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(50.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Image.network(widget.itemModel.thumbnailUrl),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: SizedBox(
                          height: 1.0,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemModel.title,
                            style: boldTextStyle,
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            widget.itemModel.longDescription,
                            style: largeTextStyle,
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            "₹"+widget.itemModel.price.toString()+"/-",
                            style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold,fontSize: 22),
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            "bank discounts can be availed at checkout!",
                            style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 11),
                          ),
                        ]
                        ,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: InkWell(
                        onTap: ()=>OrderDetails(),
                        child: Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [Colors.black, Colors.amber],
                              begin: const FractionalOffset(1.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),

                          ),
                          width: MediaQuery.of(context).size.width-40.0,
                          height: 50.0,

                          child: Center(

                            child: Text(

                              "Check Out",style: TextStyle(color:Colors.white),
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
