import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:mobilyft/Car_Insurance/Car_Insurance_CompanyList.dart';
import 'package:mobilyft/Car_Rent/Car_Rent_HomePage/car_rent_homepage.dart';
import 'package:mobilyft/Car_Sell/car_sell_home.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:mobilyft/Login_Page/loginpage.dart';
import 'package:mobilyft/Profile/profile.dart';
import 'package:mobilyft/Ride_Share/HomePage/car_share_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class section_page extends StatefulWidget {
  section_page({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _section_pageState createState() => _section_pageState();
}

class _section_pageState extends State<section_page> {
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot pro;
  String user;
 Uint8List imagef;
  StorageReference photoref = FirebaseStorage.instance.ref().child("profile");

 @override
  void initState() {
    int MAX_SIZE = 7 * 1024 * 1024;

    photoref.child("${widget.email}").getData(MAX_SIZE).then((data) {
      this.setState(() {
        imagef = data;
      });
    }).catchError((error) {});
    crudobj.getData('user').then((result) {
      setState(() {
        pro = result;
      });
    });
  }

  int l = 0;
  Future<bool> manage_back_button() {
    showDialog(
        context: context,
        builder: (_) => FlareGiffyDialog(
              flarePath: 'asets/space_demo.flr',
              flareAnimation: 'loading',
              title: Text(
                'Thank you',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                'Do you really want to exit.',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onOkButtonPressed: () {
                exit(0);
              },
            ));
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: manage_back_button,
    
    child:SafeArea(
      child: Scaffold(        
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [Colors.white,Colors.blue[200],Colors.blue]),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height ,
           child: Center(
             child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
              
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [Colors.white,Colors.blue[200],Colors.blue]),
            ),
                  accountName: user_name(), 
                  accountEmail: Text(widget.email,style: TextStyle(fontWeight:FontWeight.w300,fontSize: 19.0,color: Colors.blueGrey[900]),),
                  currentAccountPicture: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 85,
                          child: ClipOval(                          
                              child: (imagef != null)
                                  ? Image.memory(
                                      imagef,
                                      fit: BoxFit.fill,
                                    )
                                  : user_name(),                            
                          ),
                        ),
                      ), 
                ),
                
                Container(
                  
                  
                  child:Column(
                    children: <Widget>[
                      ListTile(
                        title:Text("View Profile",style: TextStyle(fontWeight:FontWeight.w500,fontSize:25.0),),
                        onTap: (){
                          Navigator.push(
                           context,
                           MaterialPageRoute(
                            builder: (BuildContext context) =>
                              profile(email: widget.email,) ));                      
                          },
                        ),
                      ],
                    ),
                  ),
               
              Padding(padding: EdgeInsets.only(top:320.0)),
              Container(
                child: Column(
                children: <Widget>[
                  Divider(color: Colors.teal),
                  ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.input,color: Colors.teal,size: 30.0,),
                          Padding(
                            padding: const EdgeInsets.only(left:2.0,top: 1.0,bottom:1.0),
                            child: Center(child: Text('Log Out',style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 30.0,color: Colors.teal),)),
                            ),
                          ],
                        ),
                  onTap:() async {                              
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('email');                       
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext ctx) => LoginPage()));
                            },
                          ),   
                        ],
                      )
                    )
                  ], 
                ),
              ),          
            ),          
          ),
  
        body: 
        Container(
           decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue[400],Colors.white,Colors.blue[200]])),
          child: ListView(
              children: <Widget>[
                Padding(padding:EdgeInsets.only(top:30.0),
                child: Center(
                  child: Text(
                    "Welcome To MobiLyft",
                    style: TextStyle(
                      fontFamily:"Merriweather",
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.blueGrey[900]
                      ),
                    )
                  ),                
                ),

              Padding(padding: EdgeInsets.only(top:35.0)),

                SizedBox(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.439,
                              height: MediaQuery.of(context).size.height*0.21,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue[200],Colors.white]
                                )
                              ),
                              child: RaisedButton(
                                color: Colors.transparent,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                              Home_page(email: widget.email),                                             
                                    )
                                  );                              
                                },
                                child: Text(
                                  'Ride Share',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.white
                                  )
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.439,
                              height: MediaQuery.of(context).size.height*0.21,
                               decoration: BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue[300],Colors.white]
                                )
                              ),
                              child: RaisedButton(
                                color: Colors.transparent,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                              rent_homepage(email: widget.email),                                             
                                    )
                                  );
                                },
                                child: Text(
                                  'Car Rent',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.white
                                  )
                                )
                              ),
                            ),
                          ],
                       ),
                      )
                    ],
                  )
                ),

            Padding(padding: EdgeInsets.only(top:35.0)),

              SizedBox(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.439,
                              height: MediaQuery.of(context).size.height*0.21,
                               decoration: BoxDecoration(
                                gradient: LinearGradient(
                               begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue[200],Colors.white]
                                )
                              ),
                              child: RaisedButton(
                                color: Colors.transparent,
                                onPressed: (){
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (BuildContext context) =>
                                  //             car_ser_selection(email: widget.email),                                             
                                  //   )
                                  // );
                                },
                                child: Text(
                                  'Car Service',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.439,
                              height: MediaQuery.of(context).size.height*0.21,
                               decoration: BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue[300],Colors.white]
                                )
                              ),
                              child: RaisedButton(
                                color: Colors.transparent,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                              sell_home(email: widget.email),                                             
                                  )
                                 );
                                },
                                child: Text(
                                  'Car sell',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.white
                                  )
                                )
                              ),
                            ),
                          ],
                       ),
                      )
                    ],
                  )
                ),

              Padding(padding: EdgeInsets.only(top:35.0)),

                SizedBox(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.439,
                              height: MediaQuery.of(context).size.height*0.21,
                               decoration: BoxDecoration(
                                gradient: LinearGradient(
                               begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue[200],Colors.white]
                                )
                              ),
                              child: RaisedButton(
                                color: Colors.transparent,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                              insurance_company(email: widget.email),                                             
                                    )
                                  );
                                },
                                child: Text(
                                  'Car Insurance',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.439,
                              height: MediaQuery.of(context).size.height*0.21,
                               decoration: BoxDecoration(
                                gradient: LinearGradient(
                               begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue[300],Colors.white]
                                )
                              ),
                              child: RaisedButton(
                                color: Colors.transparent,
                                onPressed: (){
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (BuildContext context) =>
                                  //             sell_home(email: widget.email),                                             
                                  //   )
                                  // );
                                },
                                child: Text(
                                  'About',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.white
                                  )
                                )
                              ),
                            ),
                          ],
                       ),
                      )
                    ],
                  )
                ),                   
              ],
            ),
          )
        ),
      )
    );
  }
  Widget user_name() {
    if (pro != null) {
      for (int i = 0; i <= pro.documents.length; i++) {
        if (widget.email == pro.documents[i].data['email']) {
          user = pro.documents[i].data['name'];
          return Text(
            pro.documents[i].data['name'],
            style: TextStyle(
              fontSize: 25.0,
              fontWeight:FontWeight.w600,
              color: Colors.blueGrey[900],
            ),
            textAlign: TextAlign.center,
          );
        }
      }
    } else
      return CircularProgressIndicator();
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();