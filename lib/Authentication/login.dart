
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}





class _LoginState extends State<Login>
{
 // final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String userImageUrl="";
  File _imageFile;

  get data => null;
  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      /*child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.white,Colors.white],
            begin: const FractionalOffset(1.0,0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          ),

        ),
        */
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 50.0,),
           /* InkWell(
              onTap:()=>print("Selected"),
              child: CircleAvatar(
                radius: _screenWidth*0.15,
                backgroundColor: Colors.white10,
                backgroundImage: _imageFile==null? null:FileImage(_imageFile),
                child: _imageFile==null
                    ?Icon(Icons.add_photo_alternate,size: _screenWidth * 0.15,color: Colors.grey,)
                    :null,
              ),
            ),*/
            SizedBox(height: 10.0,),
            Form(
              key: _formkey,
              child: Column(

                children:[



                  CustomTextField(

                    controller: _emailTextEditingController,

                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  SizedBox(height: 20.0,),
                  CustomTextField(

                    controller: _passwordTextEditingController,

                    data: Icons.password,
                    hintText: "Password",
                    isObsecure: true,
                  ),

                  SizedBox(height: 20.0,),
                ],

              ),
            ),

            ElevatedButton(

              onPressed: (){
                Clipboard.setData(ClipboardData(text: data));
                HapticFeedback.heavyImpact();
                _emailTextEditingController.text.isNotEmpty && _passwordTextEditingController.text.isNotEmpty
                    ? loginUser()
                    :showDialog(context: context,
                    builder: (c) {

                      return ErrorAlertDialog(message: "Please fill the form..",);
                    });
              },


              child:Text("Login", style: TextStyle(color: Colors.white,fontSize:22),),

            ),
            SizedBox(height:10.0, ),
            Container(
              height: 4.0,
              width: _screenHeight * 0.8,


            ),//nature_people
           SizedBox( height: 30.0,),
            FlatButton.icon(

              onPressed:()=>{
              Clipboard.setData(ClipboardData(text: data)),
                HapticFeedback.heavyImpact(),
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminSignInPage()))
              },

            icon: (Icon(Icons.admin_panel_settings_rounded,color: Colors.black,)),

label: Text("I am Admin",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
            ),
          ],


      ),
    );

  }

  void loginUser() async{
    showDialog
      (context: context,
        builder:(c)
    {
      return LoadingAlertDialog(message: "Logining Please wait..",);

      //Navigator.pop(LoadingAlertDialog);

    }
    );
    FirebaseUser firebaseUser;
    FirebaseAuth _auth = FirebaseAuth.instance;

    await  _auth.signInWithEmailAndPassword  (
      email : _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),

    ).then((authUser){
      firebaseUser = authUser.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(context: context,
          builder: (c){
        return ErrorAlertDialog(message: error.message.toString(),);
          });


    });
    if(firebaseUser!=null)
      {
        readData(firebaseUser).then((s)
        {
         // Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StoreHome()));
          });
          //Route  route = MaterialPageRoute(builder: (c)=> StoreHome());

            //Navigator.pushReplacement(context,route);






        });
      }
  }

Future <void> readData(FirebaseUser fUser) async
{
  Firestore.instance.collection("users").document(fUser.uid).get().then((dataSnapshot) async
  {
    await EcommerceApp.sharedPreferences.setString("uid",dataSnapshot.data[EcommerceApp.userUID]);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail,dataSnapshot.data[EcommerceApp.userEmail]);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName,dataSnapshot.data[EcommerceApp.userName]);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl , dataSnapshot.data[EcommerceApp.userAvatarUrl]);

    List<String> cartList = dataSnapshot.data[EcommerceApp.userCartList].cast<String>();
    await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,cartList);



  });
  }
}
