import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminOrderCard.dart';
import 'package:e_shop/Orders/OrderDetailsPage.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Orders/placeOrder.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';


class OrderCard extends StatelessWidget
{
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;

  OrderCard({Key key,this.data,this.itemCount,this.orderID}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return  InkWell(

      onTap: (){

        Route route=MaterialPageRoute(builder: (c)=>OrderDetails(orderID: orderID));
       /* if(counter==0)
          {
            counter = counter +1;
            route = MaterialPageRoute(builder: (c)=>OrderDetails(orderID: orderID,));

          }

        */
       Navigator.pushReplacement(context, route);
      },

      child: Container(

        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.lightGreenAccent, Colors.teal],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),

        ),

        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(19.0),
        height:itemCount*300.0,
        child: ListView.builder(
            itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (c,index){
              ItemModel model = ItemModel.fromJson(data[index].data);
              return sourceOrderInfo(model, context);
          },
          
        ),

      ),

    );
  }
}




Widget sourceOrderInfo(ItemModel model, BuildContext context,
    {Color background})
{
  width =  MediaQuery.of(context).size.width;

  return  Container(

    color: Colors.grey[100],
      height: 250.0,
      width: width,
      child: Row(
        children: [
          Image.network(model.thumbnailUrl,width: 100.0,),
          SizedBox(width:0.0,),
          Expanded(child: Column
            (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.0,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children:[
                    Expanded(
                      child: Text(model.title,style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold),),
                    ),],
                ),
              ),
              SizedBox(height: 1.0,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Expanded(
                      child: Text(model.shortInfo,style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                    ),],
                ),
              ),
              SizedBox(height: 15.0,),
              //   Column(),
              Row(
                children: [


                  Column(
                    children: [


                      // SizedBox(width: 2.0,),

                      Padding(padding: EdgeInsets.only(top: 1.0),

                        child: Row(


                          children: [
                            Text("Total Price:",style: TextStyle(fontSize: 14.0,color: Colors.pink,fontWeight: FontWeight.bold),
                            ),
                            Text("₹",style: TextStyle(fontSize: 11.0,color: Colors.red,fontWeight: FontWeight.bold),
                            ),
                            Text((model.price ).toString(),style: TextStyle(fontSize: 15.0,color: Colors.redAccent,fontWeight: FontWeight.bold),
                            ),


                          ],

                        ),
                      ),
                      ElevatedButton.icon(
                        style:ElevatedButton.styleFrom(primary: Colors.pinkAccent,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),
                              side: BorderSide(width: 3,color: Colors.pink),

                            ),
                            padding: EdgeInsets.all(3)
                        ),
                        //child:new Icon( Icons.exit_to_app),

                        // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                        onPressed: (){
                          Route route = MaterialPageRoute(builder: (c)=>OrderDetails(orderID: getOrderId));
                          Navigator.pushReplacement(context, route);
                          //BuyNow(itemModel:model)
                        },
                        icon: Icon(Icons.shopping_bag_outlined),
                        label: Text("Order Details"),

                      ),
                      //  SizedBox(width: 2.0,),

                      //




                    ],

                  ),


                ],


              ),
              Flexible(
                child: Container(



                ),
              ),



              Divider(
                thickness: 2.0,
                height: 5.0,
                color: Colors.pinkAccent,

              ),






            ],

          ),

          ),

          // SizedBox(height: 70.0,),
        ],
        // SizedBox(height: 70.0,),

      ),


  );
}
