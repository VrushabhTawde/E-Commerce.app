import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: []);

    return DefaultTabController(
      length: 1,
      child: Scaffold(
      appBar: AppBar(



        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.black,Colors.orangeAccent],
              begin: const FractionalOffset(1.0,0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            ),

          ),
        ),
        title: Text(
          "Admin Login",
          style: TextStyle(fontSize: 22.0,color: Colors.black, fontWeight: FontWeight.bold  ,) ,

        ),
        centerTitle: true,

          bottom: TabBar(
            tabs: [
              Tab(
               
                icon: Icon(Icons.admin_panel_settings_outlined, color: Colors.black,size: 35,),
              //  text: "Login",

              ),
              /*Tab(

                icon: Icon(Icons.perm_contact_calendar, color: Colors.white,),
                text: "Register",

              ),
*/
            ],

          ),




      ),
      body: AdminSignInScreen(),

      ),
      );

  }
}


class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
{
  final TextEditingController _adminIDTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  get data => null;

  @override
  Widget build(BuildContext context) {


    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.white,Colors.lightBlueAccent],
            begin: const FractionalOffset(1.0,0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          ),

        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
            //SizedBox(height: 10.0,),
            //InkWell(
             // onTap:()=>print("Selected"),
              alignment: Alignment.bottomCenter,
              child:Image.asset (
                "images/admin.png",
                height: 140.0,
                width: 240.0,



        ),
              ),
            Padding(padding: EdgeInsets.all(8.0),
            child: Text(
              "Admin",
              style: TextStyle(color: Colors.white,fontSize: 28.0,fontWeight: FontWeight.bold),
            ),
            ),




            Form(
              key: _formkey,

              child: Column(
                children:[


                  CustomTextField(
                    controller: _adminIDTextEditingController,
                    data: Icons.person,
                    hintText: "id",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.password,
                    hintText: "Password",
                    isObsecure: true,
                  ),

                ],

              ),
            ),
            SizedBox(
              height: 12.0,

            ),
            ElevatedButton(
              onPressed: ()
              
    {
      Clipboard.setData(ClipboardData(text: data));
      HapticFeedback.heavyImpact();
                _adminIDTextEditingController.text.isNotEmpty && _passwordTextEditingController.text.isNotEmpty
                    ? loginAdmin()
                    :showDialog(context: context,
                    builder: (c)
    {
                      return ErrorAlertDialog(message: "Please fill the form..",);
                    }
                     );
              },


              child:Text("Login", style: TextStyle(color: Colors.white,fontSize: 20.0,),),

            ),
            SizedBox(
              height:20.0,
            ),
            Container(
              height: 4.0,
              width: _screenHeight * 0.8,
              color: Colors.white,

            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton.icon(onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthenticScreen())),
              icon: (Icon(Icons.person_pin,color: Colors.black,)),
              label: Text("I am not Admin",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
    ),
    ),
    );




  }

  loginAdmin()
  {
    Firestore.instance.collection("admins").getDocuments().then((dataSnapshot){
      dataSnapshot.documents.forEach((result){
        if(result.data["id"]!= _adminIDTextEditingController.text.trim())
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Your id is not correct."),));
              
          
          
        }
        if(result.data["password"]!= _passwordTextEditingController.text.trim())
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Your password is not correct."),));


        }
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Welcome Dear Admin,"+ result.data["name"]),));
            setState(() {
              _adminIDTextEditingController.text = "";
              _passwordTextEditingController.text = "";

            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>UploadPage()));
            });



        }

      });

    });

  }
 
}
