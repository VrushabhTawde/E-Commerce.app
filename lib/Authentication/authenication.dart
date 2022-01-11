
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'register.dart';





class AuthenticScreen extends StatefulWidget
{

  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  //NEW
  @override
  Widget build(BuildContext context) {

  //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
return const MaterialApp(
    debugShowCheckedModeBanner:false,
        home: MyStatefulWidget(),
    );



  }
}



class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final List<Widget> _children =
  [
    Login(),
    Register(),

  ];
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  get data => null;





  void _onItemTapped(int index) {
    Clipboard.setData(ClipboardData(text: data));
    HapticFeedback.heavyImpact();
    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> _pageOptions[_selectedIndex]));
    setState(() {
      _selectedIndex = index;
    });
  }



  //NEW



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual , overlays: [SystemUiOverlay.bottom]);
    return DefaultTabController(
      length: 1,
      child: Scaffold(


backgroundColor: Colors.lightBlueAccent,//new blue

        appBar: AppBar(


          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.orangeAccent,Colors.orange],
                  begin: const FractionalOffset(0.0,0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            ),

              ),
            ),
          title: Text(
            "Sign Up!",


            style: TextStyle(fontSize: 22.0,color: Colors.black, fontWeight: FontWeight.bold  ,
                /*shadows: <Shadow>[
                Shadow(
                offset: Offset(10.0, 10.0),
            blurRadius: 3.0,
            color: Color.fromARGB(47, 0, 0, 0).withOpacity(0.2),
          ),
        ],
              */
          ),



          ),
        centerTitle: true,


          bottom: TabBar(
            tabs: [
          Tab(

          icon: Icon(Icons.person_pin, color: Colors.black,size: 35,),
          //  text: "Login",

        ),
],
          ),
/*
          bottom: TabBar(
            tabs: [
              Tab(

                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Login",

              ),
              Tab(

                icon: Icon(Icons.perm_contact_calendar, color: Colors.white,),
                text: "Register",

              ),

            ],

          ),
          */



    ),

        body: Center(
          child: _children.elementAt(_selectedIndex),



        ),

    bottomNavigationBar: BottomNavigationBar(
      onTap: _onItemTapped,
        currentIndex: _selectedIndex ,





        backgroundColor: Colors.white,

    items: const <BottomNavigationBarItem>[


    BottomNavigationBarItem(
      
    icon: Icon(Icons.lock_outline_rounded,color: Colors.black54,),

    label: 'Login',

      backgroundColor: Colors.orange,
      activeIcon:  Icon(Icons.lock_open_outlined,color: Colors.blue),






    ),
    BottomNavigationBarItem(

    icon: Icon(Icons.perm_contact_calendar_sharp),
    label: 'Register',
      activeIcon:  Icon(Icons.perm_contact_calendar_outlined),
     



    ),

    ],

/*
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.white,
    onTap: _onItemTapped,
      */

    ),

      ),
    );
  }
}












