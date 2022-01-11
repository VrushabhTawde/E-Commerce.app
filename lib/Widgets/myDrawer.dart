import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Authentication/authenication.dart';
//import 'package:swipebuttonflutter/swipebuttonflutter.dart';
import 'package:e_shop/Config/config.dart';
//import 'package:e_shop/Address/addAddress';
import 'package:e_shop/Store/Search.dart';

import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  get pageController => null;

  get data => null;


  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor:Colors.white,

      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top:25.0,bottom: 10.0),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.amber,Colors.orange],
                begin: const FractionalOffset(0.0,0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              ),

            ),
            child: Column(
              children: [
              Material(
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                elevation: 8.0,
                child: Container
                  (
                  height:93.0,
                  width:96.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl),

                    ),
                  ),
                ),
              ),






              SizedBox(height: 10.0,),
                Text("Welcome,",style: TextStyle(color: Colors.white,fontFamily: "Signatra",fontSize: 20.0,),),
                Text(
                  EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
                  style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold  ,),


                ),
          ],
              ),
            ),
SizedBox(height:0.0,),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.black54,Colors.blue[100]],
                begin: const FractionalOffset(0.0,0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              ),

            ),
            child: Column(
              children: [



             /*   ListTile(
                  leading: Icon(Icons.home,color: Colors.black,),
                  title: Text("Home",style: TextStyle(color: Colors.white),),
                  onTap: (){
    Route route = MaterialPageRoute(builder: (c)=> StoreHome());

    Navigator.pushReplacement(context,route);

    },

            ),*/
   // Divider(height:10.0,color: Colors.white,thickness:6.0,),





            //////////////////////////////////////////////////
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 5.0,horizontal: 5.0
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: width,
                      height: 60,
                      color: Colors.white,
                      child: Row(

                        children: <Widget>[

                          ElevatedButton.icon(


                            style:ElevatedButton.styleFrom(primary: Colors.amber,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),
                                  //side: BorderSide(width: 3,color: Colors.white),

                                ),
                                padding: EdgeInsets.all(20)
                            ),
                            //child:new Icon( Icons.exit_to_app),

                            // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                            onPressed: (){
                              Clipboard.setData(ClipboardData(text: data));
                              HapticFeedback.vibrate();

                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StoreHome()));
                            },
                            icon: Icon(Icons.arrow_back),
                            label: Text(""),

                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children:[
                                Text('Back'),
                                Text('back to home!',
                                    style: TextStyle(color: Colors.grey,fontSize: 11.0,))
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 5.0,horizontal: 5.0
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: width,
                      height: 60,
                      color: Colors.white,
                      child: Row(

                        children: <Widget>[

                          ElevatedButton.icon(



                            style:ElevatedButton.styleFrom(primary: Colors.amber,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),
                                  //side: BorderSide(width: 3,color: Colors.white),

                                ),
                                padding: EdgeInsets.all(20)
                            ),
                            //child:new Icon( Icons.exit_to_app),

                            // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                            onPressed: (){
                              Clipboard.setData(ClipboardData(text: data));
                              HapticFeedback.heavyImpact();

                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyOrders()));
                            },
                            icon: Icon(Icons.exit_to_app),
                            label: Text(""),

                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children:[
                                Text('My Order'),
                                Text('Edit Your Address here!',
                                    style: TextStyle(color: Colors.grey,fontSize: 11.0,))
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 5.0,horizontal: 5.0
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: width,
                      height: 60,
                      color: Colors.white,
                      child: Row(

                        children: <Widget>[

                          ElevatedButton.icon(


                            style:ElevatedButton.styleFrom(primary: Colors.amber,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),
                                  //side: BorderSide(width: 3,color: Colors.white),

                                ),
                                padding: EdgeInsets.all(20)
                            ),
                            //child:new Icon( Icons.exit_to_app),

                            // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                            onPressed: (){
                              Clipboard.setData(ClipboardData(text: data));
                              HapticFeedback.heavyImpact();

                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartPage()));
                            },
                            icon: Icon(Icons.shopping_cart),
                            label: Text(""),

                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children:[
                                Text('Cart'),
                                Text('CheckOut your Shopping Cart!',
                                    style: TextStyle(color: Colors.grey,fontSize: 11.0,))
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 5.0,horizontal: 5.0
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: width,
                      height: 60,
                      color: Colors.white,
                      child: Row(

                        children: <Widget>[

                          ElevatedButton.icon(


                            style:ElevatedButton.styleFrom(primary: Colors.amber,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),
                                  //side: BorderSide(width: 3,color: Colors.white),

                                ),
                                padding: EdgeInsets.all(20)
                            ),
                            //child:new Icon( Icons.exit_to_app),

                            // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                            onPressed: (){
                              Clipboard.setData(ClipboardData(text: data));
                              HapticFeedback.heavyImpact();

                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchProduct()));
                            },
                            icon: Icon(Icons.search_rounded),
                            label: Text(""),

                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children:[
                                Text('Search'),
                                Text('Search your favourite product!',
                                    style: TextStyle(color: Colors.grey,fontSize: 11.0,))
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
padding: EdgeInsets.symmetric(
                      vertical: 5.0,horizontal: 5.0
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: width,
                      height: 60,
                      color: Colors.white,
                      child: Row(

                        children: <Widget>[

                          ElevatedButton.icon(


                            style:ElevatedButton.styleFrom(primary: Colors.amber,
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),
                           //side: BorderSide(width: 3,color: Colors.white),

                              ),
                              padding: EdgeInsets.all(20)
                            ),
                             //child:new Icon( Icons.exit_to_app),

   // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                            onPressed: (){
                              Clipboard.setData(ClipboardData(text: data));
                              HapticFeedback.heavyImpact();

                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AuthenticScreen()));
                            },
                            icon: Icon(Icons.exit_to_app),
                            label: Text(""),

                          ),
SizedBox(width: 10),
                          Expanded(
 child: Column(
mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children:[
                                Text('LogOut'),
                                Text('logout form home!',
                                    style: TextStyle(color: Colors.grey,fontSize: 11.0,))
 ],
                            ),
                          ),

],
                      ),
                    ),
                  ),
                ),
Padding(
    padding: EdgeInsets.symmetric(
    vertical: 5.0,horizontal: 5.0
    ),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
    width: width,
    height: 60,
    color: Colors.white,
    child: Row(

    children: <Widget>[

    ElevatedButton.icon(


    style:ElevatedButton.styleFrom(primary: Colors.amber,
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),
    //side: BorderSide(width: 3,color: Colors.white),

    ),
    padding: EdgeInsets.all(20)
    ),
    //child:new Icon( Icons.exit_to_app),

    // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
    onPressed: (){

      Clipboard.setData(ClipboardData(text: data));
      HapticFeedback.heavyImpact();
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Address()));
    },
    icon: Icon(Icons.exit_to_app),
    label: Text(""),

    ),
    SizedBox(width: 10),
    Expanded(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment:
    CrossAxisAlignment.start,
    children:[
    Text('Address'),
    Text('Edit Your Address here!',
    style: TextStyle(color: Colors.grey,fontSize: 11.0,))
    ],
    ),
    ),

    ],
    ),
    ),
    ),
    ),

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







    /*
                  ListTile
                  (



                  leading: Icon(Icons.home  ,color: Colors.black,),

                  title: Text("Home",style: TextStyle(color: Colors.white),),



                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c)=> StoreHome());

                    Navigator.pushReplacement(context,route);

                  },

                ),*/


              /*  Divider(height:10.0,color: Colors.white,thickness:6.0,),
                ListTile(
                  leading: Icon(Icons.shopping_cart,color: Colors.black,),
                  title: Text("Cart",style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c)=> CartPage());

                    Navigator.pushReplacement(context,route);

                  },

                ),

               */
                /*
                Divider(height:10.0,color: Colors.white,thickness:6.0,),
                ListTile(
                 // minLeadingWidth: 30.0,
                  leading: Icon(Icons.search,color: Colors.black,),
                  title: Text("Search",style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c)=> SearchProduct());

                    Navigator.pushReplacement(context,route);

                  },

                ),

                 */
                /*
                Divider(height:10.0,color: Colors.white,thickness:6.0,),
                ListTile(
                  leading: Icon(Icons.add_location,color: Colors.black,),
                  title: Text("Add New Address",style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c)=> AddAddress());

                    Navigator.pushReplacement(context,route);

                  },

                ),
                Divider(height:10.0,color: Colors.white,thickness:6.0,),
                ListTile(
                  leading: Icon(Icons.logout,color: Colors.black,),
                  title: Text("Logout",style: TextStyle(color: Colors.white),),
                  onTap: (){
                    EcommerceApp.auth.signOut().then((c){
                      Route route = MaterialPageRoute(builder: (c)=> AuthenticScreen());

                      Navigator.pushReplacement(context,route);


                    });

                  },

                ),
              //  Divider(height:10.0,color: Colors.white,thickness:6.0,),



                 */
        ],

      ),
    ),
    ],
    ),


    );

   // ),
    //),
    //],
      //),
    //);

  }
}
