import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';

//import 'package:e_shop/Store/cart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';
import 'cart.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();

}

class _StoreHomeState extends State<StoreHome> {
  get data => null;

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /*
  final ScrollController _sc = ScrollController();
  List<String> items = [];
  bool loading = false,
      allLoaded = false;

  mockFetch() async {
    if (allLoaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    List<String> newData = items.length >= 60 ? [] : List.generate(
        20, (index) => "List Item${index + items.length}");
    if (newData.isNotEmpty) {
      items.addAll(newData);
    }
    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    mockFetch();
    _sc.addListener(() {
      if (_sc.position.pixels >= _sc.position.maxScrollExtent && !loading) {
        // print ("new data call");
        mockFetch();
      }
    });
  }

  @override
  void dispose() {
    //ToDo: implemrnt dipose
    _sc.dispose();
  }
*/
  /*
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("infinite Scrolling"),
      ),
      body: LayoutBuilder(builder: (context,constraints){
        return Container(
          child: Center(
            child: circularProgress(),

          ),
        );

      }),
    );
  }


   */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    return DefaultTabController(

      length: 1,

      child: Scaffold(
        //   backgroundColor: Colors.white,

        appBar: AppBar(
          title: Text("shop here!", style: TextStyle(color: Colors.pinkAccent,
              fontWeight: FontWeight.normal,
              fontFamily: "Signatra",
              fontSize: 33.0),),

          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.amber, Colors.orange],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),

            ),
          ),
          /*

    */
          centerTitle: true,

          //backgroundColor: Colors.amber,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.pink,
                    size: 33,),

                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: data));
                    HapticFeedback.heavyImpact();
                    Route route = MaterialPageRoute(builder: (c) => CartPage());
                    Navigator.pushReplacement(context, route);
                  },

                ),
                Positioned(
                  child: Stack(
                    children: [
                      Icon(
                        Icons.brightness_1,
                        size: 20.0,
                        color: Colors.green,


                      ),

                      Positioned(
                        top: -1.0,
                        bottom: 4.0,
                        left: 4.0,
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, _) {
                            return Text(
                              (EcommerceApp.sharedPreferences
                                  .getStringList(EcommerceApp.userCartList)
                                  .length - 1).toString(),
                              // counter.count.toString(),
                              style: TextStyle(color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),

                            );
                          },

                        ),
                      ),
                    ],
                  ),),
              ],
            )
          ],


          //title: Text("infinite Scrolling"),
        ),
        drawer: MyDrawer(),


        body: CustomScrollView(

          slivers: [

            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder <QuerySnapshot>(
              stream: Firestore.instance.collection("items").orderBy(
                  "publishedDate", descending: true).snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                  child: Center(child: circularProgress(),),)
                    : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    ItemModel model = ItemModel.fromJson(
                        dataSnapshot.data.documents[index].data);
                    return sourceInfo(model, context);
                  },
                  itemCount: dataSnapshot.data.documents.length,
                );
                //  ],

/*
    children:
    [
    LayoutBuilder(builder: (context, constraints) {
    if (items.isNotEmpty) {
    return Stack(
    children: [
    ListView.separated(
    controller: _sc,
    itemBuilder: (context, index) {
    if (index < items.length) {
    return ListTile(
    title: Text(items[index]),
    );
    }
    else {
    return Container(
    width: constraints.maxWidth,
    height: 50,
    child: Center(
    child: Text("nothing more to load"),
    ),
    );
    }
    }, separatorBuilder: (context, index) {
    return Divider(height: 1,);
    }, itemCount: items.length + (allLoaded ? 1 : 0)),
    if(loading)...[
    Positioned(
    left: 0,
    bottom: 0,

    child: Container(
    width: constraints.maxWidth,
    height: 80,
    child: Center(

    child: circularProgress(),


    ),
    ))
    ]

    ],
    );
    }
    else {
    return Container(
    child: Center(
    child: circularProgress(),
    ),
    );
    }
    }


    );


*/
              },

            ),
          ],
        ),
      ),

    );
  }
}

  Widget sourceInfo(ItemModel model, BuildContext context,
      {Color background,removeCartFunction})
  {

    return InkWell(
      onTap: (){
        var data;
        Clipboard.setData(ClipboardData(text: data));
      HapticFeedback.heavyImpact();


        Route route = MaterialPageRoute(builder: (c)=> ProductPage(itemModel:model));
        Navigator.pushReplacement(context,route);

      },
      splashColor: Colors.grey,
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
         // color: Colors.grey,
          height: 250.0,
          width: width,
          child: Row(
            children: [
              Image.network(model.thumbnailUrl,width: 105.0,height: 140.0,),
              SizedBox(width:5.0,),
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
                        child: Text(model.title,style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold),),
                      ),],
                    ),
                  ),
                  SizedBox(height: 9.0,),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children:[
                        Expanded(
                          child: Text(model.shortInfo,style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                        ),],
                    ),
                  ),
                  SizedBox(height: 13.0,),
              //   Column(),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                     shape:   BoxShape.rectangle,
                        color:Colors.pink,
                        ),
                        alignment: Alignment.topLeft,

                        width:50.0,
                       height: 50.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("50%",style:TextStyle(fontSize:15.0,color: Colors.white,fontWeight:FontWeight.normal),
                              ),
                              Text("OFF",style:TextStyle(fontSize:12.0,color: Colors.white,fontWeight:FontWeight.normal),
                              ),


                            ],
                          ),
                        ),


                      ),
                      SizedBox(width: 7.0,),
                      Column(
                        children: [

                          Padding(padding: EdgeInsets.only(top: 0.0),
                          child: Row(
                            children: [
                              Text("Price:₹",style: TextStyle(fontSize: 12.0,color: Colors.grey,decoration: TextDecoration.lineThrough),
                              ),
                              Text(( model.price + model.price).toString(),style: TextStyle(fontSize: 13.0,color: Colors.grey,decoration: TextDecoration.lineThrough),
                              ),

                            ],
                          ),
                          ),
                         // SizedBox(width: 2.0,),

                          Padding(padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                              Text("New:",style: TextStyle(fontSize: 14.0,color: Colors.pink),
                                ),
                                Text("₹",style: TextStyle(fontSize: 11.0,color: Colors.red),
                                ),
                                Text((model.price ).toString(),style: TextStyle(fontSize: 15.0,color: Colors.redAccent),
                                ),


                              ],
                            ),
                          ),
                        // SizedBox(width: 2.0,),

                          //




                        ],

                      ),


                    ],


                  ),
                  Flexible(
                      child: Container(


                      ),
                  ),
                    Align(
                    alignment: Alignment.topRight,
                    child:removeCartFunction == null
                      ? IconButton(
                      icon:Icon(Icons.add_shopping_cart,color:Colors.pinkAccent,),
                        onPressed:()

                        {
                          var data=null;
                          Clipboard.setData(ClipboardData(text: data));
                          HapticFeedback.heavyImpact();
                        checkItemInCart(model.shortInfo, context);
                    },
                    )

                   : IconButton

                      (
                      icon: Icon(Icons.delete,color:Colors.pinkAccent),
                      onPressed:()
                        {
                          var data;
                          Clipboard.setData(ClipboardData(text: data));
                          HapticFeedback.heavyImpact();
                          removeCartFunction();
                          Route route = MaterialPageRoute(builder:(c)=>StoreHome());
                          Navigator.pushReplacement(context, route);

                        },
                    ),
                    ),



                 /* ElevatedButton.icon(
                   style:ElevatedButton.styleFrom(primary: Colors.pinkAccent,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(width: 3,color: Colors.pink),

                        ),
                       padding: EdgeInsets.all(3)
                    ),
                    //child:new Icon( Icons.exit_to_app),

                    // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                    onPressed: (){
                      Clipboard.setData(ClipboardData(text: data));
                      HapticFeedback.heavyImpact();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaymentPage()));
                      //BuyNow(itemModel:model)
                    },
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: Text("Buy"),

                  ),

                  */
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

        ),


      ),

    );
  }




//    );




Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container(
    height:150.0,
    width:width*.34,
    margin:EdgeInsets.symmetric(horizontal:10,vertical:10),
    decoration:BoxDecoration(
      color:primaryColor,
      borderRadius:BorderRadius.all(Radius.circular(20.0)),
      boxShadow: <BoxShadow>
      [
        BoxShadow(offset:Offset(0,5),blurRadius:10.0,color:Colors.black54)
      ]

    ),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.9)),
       child: Image.network(
         imgPath,
         height: 150.0,
         width: width*.34,
         fit: BoxFit.fill,
       ),
    ),
  );
}



void checkItemInCart(String shortInfoAsID, BuildContext context)
{
  EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).contains(shortInfoAsID)
      ?Fluttertoast.showToast(msg: "item is already in cart")
      :addItemToCart(shortInfoAsID,context);


}

addItemToCart(String shortInfoAsID, BuildContext context) {
  List tempCartlist = EcommerceApp.sharedPreferences.getStringList(
      EcommerceApp.userCartList);
  tempCartlist.add(shortInfoAsID);

  EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({
    EcommerceApp.userCartList: tempCartlist,

  }).then((value) =>
      (v) {
    Fluttertoast.showToast(msg: "item Added to Cart Successfully.");
    EcommerceApp.sharedPreferences.setStringList(
        EcommerceApp.userCartList, tempCartlist);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}







