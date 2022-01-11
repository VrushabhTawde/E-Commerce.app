import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/services.dart';
import '../Models/item.dart';

class ProductPage extends StatefulWidget
{
  final ItemModel itemModel;
  ProductPage({this.itemModel});
  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage>
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
              padding: EdgeInsets.all(5.0),
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
                          SizedBox(height: 15.0,),
                          Text(
                            widget.itemModel.longDescription,
                            style: largeTextStyle,
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            "₹"+widget.itemModel.price.toString()+"/-",
                            style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold,fontSize: 22),
                          ),

                        ]
                        ,
                      ),
                    ),
                  ),
                  /*
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: InkWell(
                        onTap: ()=>checkItemInCart(widget.itemModel.shortInfo, context),
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

                          ),

                        ),

                      ),
                    ),
                  ),
                  */

                ],

              ),
            ),
            ElevatedButton(
                child: Text("BUY NOW",style: TextStyle(color: Colors.white,backgroundColor: Colors.pinkAccent,fontSize: 22,),),
              onPressed: (){
                var data=null;
                Clipboard.setData(ClipboardData(text: data));
                HapticFeedback.heavyImpact();
                checkItemInCart(widget.itemModel.shortInfo, context);
              },
            ),
          ],
        ),
      ),
    );
  }

}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
