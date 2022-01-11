import 'dart:io';

import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';

import 'package:e_shop/Config/config.dart';



class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register>
{
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _cpasswordTextEditingController = TextEditingController();
 final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
 String userImageUrl="";
 File _imageFile;//

  get imagePicker => null;

  get data => null;
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 10.0,),
            InkWell(
              onTap:()=>_selectAndPickImage(),
              child: CircleAvatar(
                radius: _screenWidth*0.15,
                backgroundColor: Colors.white,
                backgroundImage: _imageFile==null? null:FileImage(_imageFile),
                child: _imageFile==null
                    ?Icon(Icons.add_photo_alternate,size: _screenWidth * 0.15,color: Colors.grey,)
                    :null,
              ),
            ),
            SizedBox(height: 8.0,),
            Form(
              key: _formkey,
              child: Column(
                children:[
                  CustomTextField(
                    controller: _nameTextEditingController,
                    data: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.password,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                  CustomTextField(
                    controller: _cpasswordTextEditingController,
                    data: Icons.password,
                    hintText: "Confirm Password",
                    isObsecure: true,
                  ),
               ],

              ),
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: data));
                HapticFeedback.heavyImpact();
                
             //   _selectAndPickImage();
              uploadAndSaveImage();
              },

                child:Text("SignUp", style: TextStyle(color: Colors.white),),

            ),
            SizedBox(
              height:30.0,
            ),
            Container(
              height: 4.0,
              width: _screenHeight * 0.8,


            ),
            SizedBox(
              height: 15.0,
            ),
          ],

        ),
      ),
    );

  }

  Future<void> _selectAndPickImage() async{


   _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery) ;



  }
  Future<void> uploadAndSaveImage() async{
    if(_imageFile==null)
      {
        showDialog(context: context,
            builder: (context)
            {
              return ErrorAlertDialog(message: "please select the image file",);

            }
        );
      }
    else
      {
        _passwordTextEditingController.text ==_cpasswordTextEditingController.text ?
        _emailTextEditingController.text.isNotEmpty &&
            _passwordTextEditingController.text.isNotEmpty &&
            _cpasswordTextEditingController.text.isNotEmpty &&
            _nameTextEditingController.text.isNotEmpty

            ? uploadToStorage()
            : displayDialog("please fill up the complete form..")
            :displayDialog("passsword do not match");



      }

  }

  displayDialog(String msg) {
    showDialog(context: context,
        builder:(context)
    {
      return ErrorAlertDialog(message: msg,);

    });
  }

  uploadToStorage() async{

    showDialog(context: context,
        builder:(context)
    {
      return LoadingAlertDialog(message:' "Registering Please Wait.."',);

    }


    );
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference = FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

    await taskSnapshot.ref.getDownloadURL().then((urlImage)
    {
      userImageUrl = urlImage;

      _registerUser();

    });
  }
  FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser() async{
    FirebaseUser firebaseUser;
    await _auth.createUserWithEmailAndPassword
      (
        email: _emailTextEditingController.text.trim(),
        password: _passwordTextEditingController.text.trim(),
       ).then((auth)
    {
      firebaseUser = auth.user;
    })
        .catchError((onError){
      Navigator.pop(context);
      showDialog(
        context: context,
        builder:(context)
          {
            return ErrorAlertDialog(message:onError.message.toString(),);
          }
      );

    });

    if(firebaseUser != null)
    {
      saveUserInfoFireStore(firebaseUser).then((value)
      {

        //Navigator.pop(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StoreHome()));
        });
        //Route route = MaterialPageRoute(builder: (c)=> StoreHome());
        //Navigator.pushReplacement(context,route );
        //return LoadingAlertDialog(message:' "Loading home Please Wait.."',);
      });
    }

  }

  Future<void> saveUserInfoFireStore(FirebaseUser fUser)
  async
  {
    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email":fUser.email,
      "name":_nameTextEditingController.text.trim(),
      "url":userImageUrl,
      EcommerceApp.userCartList:["garbageValue"]

    });
await EcommerceApp.sharedPreferences.setString("uid",fUser.uid);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail,fUser.email);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName,_nameTextEditingController.text);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl , userImageUrl);
    await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,["garbageValue"]);

  }

}


