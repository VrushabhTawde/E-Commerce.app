import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;


class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{
  bool get wantKeepAlive => true;
  File file ;
  TextEditingController _descriptiontextEditingController = TextEditingController();
  TextEditingController _pricetextEditingController = TextEditingController();
  TextEditingController _titletextEditingController = TextEditingController();
  TextEditingController _shortInfotextEditingController = TextEditingController();
String productId = DateTime.now().millisecondsSinceEpoch.toString();
bool uploading = false;
  @override
  Widget build(BuildContext context) {
    return file == null? displayAdminHomeScreen() : displayAdminUploadHomeScreen();
  }
  displayAdminHomeScreen()
  {
    return Scaffold(
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
        leading: IconButton(
          icon: Icon(Icons.border_color,color: Colors.white,),
          onPressed: (){
            Route route = MaterialPageRoute(builder: (c)=>AdminShiftOrders());
            Navigator.pushReplacement(context, route);
          },
        ),
        actions: [
          FlatButton( child: Text("Logout",style: TextStyle(color: Colors.pink,fontSize: 16.0,fontWeight: FontWeight.bold),),
          onPressed: (){
            Route route = MaterialPageRoute(builder: (c)=>SplashScreen());
            Navigator.pushReplacement(context, route);

          },),

        ],

      ),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.black,Colors.orangeAccent],
          begin: const FractionalOffset(1.0,0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0,1.0],
          tileMode: TileMode.clamp,
        ),

      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two,color: Colors.white,size: 200.0,),
  Padding(
    padding: EdgeInsets.only( top: 20.0),
    child: ElevatedButton(
      style: ButtonStyle(
        shape:MaterialStateProperty.all<RoundedRectangleBorder>
          (
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),

        //Colors.green,
        ),
      ),
      child: Text("Add new Items",style: TextStyle(fontSize: 20.0,color: Colors.white),),

      onPressed: (){
        return showDialog(
            context: context,
            builder:(con)
            {
    return SimpleDialog(
    title: Text("Items Image",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
    children: [
    SimpleDialogOption(
    child:Text("Capture with camera",style: TextStyle(color: Colors.green,)),
    onPressed:capturePhotoWithCamera,
    ),

    SimpleDialogOption(
    child:Text("Select from gallery",style: TextStyle(color: Colors.green,)),
    onPressed:pickPhotoFromGallery,
    ),
    SimpleDialogOption(
    child:Text("cancel",style: TextStyle(color: Colors.green,)),
    onPressed:(){
    Navigator.pop(context);
    },
    ),


    ],
    );


    }
    );


    },


    ),
  ),
          ],
        ),
      ),


    );
  }
/*
  takeImage(context)
  {
    return showDialog(
        context: context,
        builder:(con)
        {
          return SimpleDialog(
           title: Text("Items Image",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child:Text("Capture with camera",style: TextStyle(color: Colors.green,)),
                onPressed:capturePhotoWithCamera,
              ),

            SimpleDialogOption(
              child:Text("Select from gallery",style: TextStyle(color: Colors.green,)),
              onPressed:pickPhotoFromGallery,
            ),
              SimpleDialogOption(
                child:Text("cancel",style: TextStyle(color: Colors.green,)),
                onPressed:(){
                  Navigator.pop(context);
                },
              ),


          ],
          );


        }
    );
  }
  */
  capturePhotoWithCamera()async{
   //Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 680.0,maxWidth: 970.0);
    setState(() {
       file= imageFile;
    });

  }
  pickPhotoFromGallery()async{
   // Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,);
    setState(() {
      file = imageFile;
    });

  }

  displayAdminUploadHomeScreen()
  {
    return Scaffold(
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
        leading: IconButton(icon:Icon( Icons.arrow_back,color: Colors.white,),
        onPressed: clearFormInfo
        ),
        title: Text("new Product ",style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold,),),
        actions: [
          FlatButton(
            onPressed:uploading ? null:()=> uploadImageAndsaveItemInfo(),


            child: Text("Add",style:TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 16.0,),),
          ),
        ],

      ),
body: ListView(
  children: [
    uploading ? linearProgress():Text(""),
    Container(
      height: 230.0,
      width: MediaQuery.of(context).size.width*0.8,
      child: Center(
        child: AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            decoration: BoxDecoration(image:DecorationImage(image: FileImage(file),fit: BoxFit.cover)),
          ),
        ),
      ) ,
    ),
    Padding(padding: EdgeInsets.only(top: 12.0)),
    ListTile(
      leading: Icon(Icons.perm_device_information,color: Colors.pink,),
      title: Container(
        width: 250.0,
        child: TextField(
          style: TextStyle(color: Colors.deepPurpleAccent),
          controller: _shortInfotextEditingController,
          decoration: InputDecoration(
            hintText: "Short Info",
            hintStyle: TextStyle(color: Colors.deepPurpleAccent),
            border: InputBorder.none,
          ),
        ),
      ),
    ),
    Divider(color: Colors.pink,),
    ListTile(
      leading: Icon(Icons.perm_device_information,color: Colors.pink,),
      title: Container(
        width: 250.0,
        child: TextField(
          style: TextStyle(color: Colors.deepPurpleAccent),
          controller: _titletextEditingController,
          decoration: InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(color: Colors.deepPurpleAccent),
            border: InputBorder.none,
          ),
        ),
      ),
    ),
    Divider(color: Colors.pink,) ,
    ListTile(
      leading: Icon(Icons.perm_device_information,color: Colors.pink,),
      title: Container(
        width: 250.0,
        child: TextField(
          style: TextStyle(color: Colors.deepPurpleAccent),
          controller: _descriptiontextEditingController,
          decoration: InputDecoration(
            hintText: "Discription",
            hintStyle: TextStyle(color: Colors.deepPurpleAccent),
            border: InputBorder.none,
          ),
        ),
      ),
    ),
    Divider(color: Colors.pink,),
    ListTile(
      leading: Icon(Icons.perm_device_information,color: Colors.pink,),
      title: Container(
        width: 250.0,
        child: TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.deepPurpleAccent),
          controller: _pricetextEditingController,
          decoration: InputDecoration(
            hintText: "Price",
            hintStyle: TextStyle(color: Colors.deepPurpleAccent),
            border: InputBorder.none,
          ),
        ),
      ),
    ),
    Divider(color: Colors.pink,)
  ],
),
    );
  }
  clearFormInfo()
  {
    setState(() {
      file = null;
      _descriptiontextEditingController.clear();
      _pricetextEditingController.clear();
      _shortInfotextEditingController.clear();
    });

  }
  uploadImageAndsaveItemInfo()async
  {
    setState(() {
      uploading = true;

    });

String imageDownloadUrl = await uploadImageItem(file);
saveItemInfo(imageDownloadUrl);
  }
  Future<String>uploadImageItem(mFileImage)async{
    final StorageReference storageReference = FirebaseStorage.instance.ref().child("items");
    StorageUploadTask uploadTask = storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadurl = await taskSnapshot.ref.getDownloadURL();
    return downloadurl;

  }

   saveItemInfo(String downloadUrl) {
final itemsRef = Firestore.instance.collection("items");
itemsRef.document(productId).setData({
  "shortInfo":_shortInfotextEditingController.text.trim(),
"longDescription":_descriptiontextEditingController.text.trim(),
  //"price":_pricetextEditingController.text.trim(),

  "price":int.parse(_pricetextEditingController.text),
  "publishedDate":DateTime.now(),
  "status":"available",
  "thumbnailUrl":downloadUrl,
  "title":_titletextEditingController.text.trim(),
});

setState(() {
  file = null;
  uploading = false;
  productId = DateTime.now().millisecondsSinceEpoch.toString();
  _descriptiontextEditingController.clear();
  _titletextEditingController.clear();
  _shortInfotextEditingController.clear();
  _pricetextEditingController.clear();
});

   }

}
