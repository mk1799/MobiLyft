import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'car_share_ride_create.dart';
import 'car_share_ridesearch.dart';
class Ride_Page extends StatefulWidget {
  Ride_Page({Key key, this.email}) : super(key: key);
  final String email;
  @override
  _Ride_PageState createState() => _Ride_PageState();
}
class _Ride_PageState extends State<Ride_Page> {
  final formKey = GlobalKey<FormState>();
  QuerySnapshot car;
  CRUD1 crudobj = new CRUD1();
  String email, lic, model, eng,chas;
  @override
  void initState() {
    email = widget.email;
    print(email);
    crudobj.getData('car_detail').then((result) {
      setState(() {
        car = result;
      });
    });
  }
  void insert(BuildContext context) {
    Map<String, dynamic> data = {
      'email': widget.email,
      'car Number': model,
      'License': lic,
      'Chassis No': chas,
      'Engine No':eng
    };
    crudobj.adddata(data, context,"car_detail").then((result) {}).catchError((e) {
      print(e);
    });
    
  }
  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
  void submit() async {
    if (validateAndSave()) {
      insert(context);
      Navigator.pop(context,true);
      
      print("submitted");
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>Create(email: widget.email)));
                                              
    }
  }

  Future<bool> updateDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(  
              child: Text(
                "Add Car Details First!!",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300
                      ),
                     // controller: TextEditingController(),
                      textCapitalization: TextCapitalization.characters, 
                      inputFormatters: [MaskTextInputFormatter(
                        mask: "## ** ## ****", 
                        filter: { "#": RegExp(r'[A-Z]') , "*":RegExp(r'[0-9]')})],
                      decoration: InputDecoration(
                        labelText: 'Car Number',
                        labelStyle:
                        TextStyle(color: Colors.grey[900],  fontSize: 25.0,fontWeight: FontWeight.w400),
                        hintText: 'GJ 05 AA 1111'
                      ),
                      validator: (value) =>
                        value.isEmpty ? "Car Number can't be empty" : null,
                      onSaved: (value) {
                        this.model = value;
                      },
                    ),

                    TextFormField(
                      style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300
                      ),
                     // controller: TextEditingController(),
                      textCapitalization: TextCapitalization.characters, 
                      inputFormatters: [MaskTextInputFormatter(
                        mask: "##** ***********", 
                        filter: { "#": RegExp(r'[A-Z]') , "*":RegExp(r'[0-9]')})],
                      decoration: InputDecoration(
                        labelText: 'License Number',
                        labelStyle:
                        TextStyle(color: Colors.grey[900],  fontSize: 25.0,fontWeight: FontWeight.w400),
                        hintText: 'GJ05 00223331111'
                      ),
                      validator: (value) =>
                        value.isEmpty ? "License Number can't be empty" : null,
                      onSaved: (value) {
                        this.lic = value;
                      },
                    ),

                    TextFormField(
                      style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300
                      ),
                      //controller: TextEditingController(),
                      textCapitalization: TextCapitalization.characters, 
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: "#################", 
                          filter: { "#": RegExp(r'[A-Z,0-9]') }
                        )
                      ],
                      decoration: InputDecoration(
                        labelText: 'Chassis Number',
                        labelStyle:
                        TextStyle(color: Colors.grey[900],  fontSize: 25.0,fontWeight: FontWeight.w400),
                        hintText: 'MA7878JK76GG88OOO'
                      ),
                      validator: (value) =>
                        value.isEmpty ? "Chassis Number can't be empty" : null,
                      onSaved: (value) {
                        this.chas = value;
                      },
                    ),

                    TextFormField(
                      style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300
                      ),
                     // controller: TextEditingController(),
                      textCapitalization: TextCapitalization.characters, 
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: "############", 
                          filter: { "#": RegExp(r'[A-Z,0-9]') }
                        )
                      ],
                      decoration: InputDecoration(
                        labelText: 'Engine Number',
                        labelStyle:
                        TextStyle(color: Colors.grey[900],  fontSize: 25.0,fontWeight: FontWeight.w400),
                        hintText: 'GJ3934KK2345'
                      ),
                      validator: (value) =>
                        value.isEmpty ? "Engine Number can't be empty" : null,
                      onSaved: (value) {
                        this.eng = value;
                      },
                    ),                    
                  ]
                ),
              ),
            ),
          ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 25.0),
                ),
                onPressed: () {
                  submit();
                },
              ),
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 25.0),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        }
      );
    }

  int flag = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          body: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:30.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.25,
                    width: MediaQuery.of(context).size.width*0.55,
                    child: RaisedButton(
                      onPressed: () {
                              if (car != null)
                                for (int i = 0; i < car.documents.length; i++) {
                                  if (email == car.documents[i].data["email"]) {
                                    print(car.documents[i].data["car"]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>Create(email: widget.email)));
                                    flag = 1;
                                  }
                                }
                              if (flag == 0) {
                                print("No Data!!");
                                updateDialog(context);
                              }
                            },
                      child: Icon(Icons.directions_car,size:130),
                      color: Colors.white,
                      shape: CircleBorder()
                    ),
                  ),
                ],
              ),

            Padding(padding: EdgeInsets.only(top:10.0)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Add Ride',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w600
                    )
                  ),
                ),
              ),

            Padding(padding: EdgeInsets.only(top:20.0)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.width*0.55,
                child: Center(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ridesearch(email: widget.email,)
                                    )
                              );
                    },
                    child: Icon(Icons.search,size: 150,),
                    shape: CircleBorder(),
                    color: Colors.white,
                  )
                ),
              ), 
            
            Padding(padding: EdgeInsets.only(top:10.0)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Search Ride',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w600
                    )
                  ),
                ),
              ),

            ],
          ),
      ),
    );
  }
}
