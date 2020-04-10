import 'package:animated_card/animated_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
class car_details extends StatefulWidget {
  final String email;
  car_details({Key key, this.email}) : super(key: key);
  @override
  _car_detailsState createState() => _car_detailsState();
}
class _car_detailsState extends State<car_details> {
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  CRUD1 crudobj = new CRUD1();
  String _email;
  String _model;
  String _rc;
  String _lic;
  QuerySnapshot pro;
  final formKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
  @override
  void initState() {
    crudobj.getData('car_detail').then((result) {
      setState(() {
        pro = result;
      });
    });
  }

  int l = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
          ),
          backgroundColor: Colors.white,
           iconTheme: IconThemeData(
            color: Colors.black
          ),
           
          title:Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text(
                "Vehicle Detail",
                style: TextStyle(
                  color:Colors.black,
                  fontWeight:FontWeight.w400,
                  fontSize: 30.0
                  ),
               ),
          ),
            leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), 
            onPressed:(){
              Navigator.pop(context, true);
            }
            ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            if (pro != null)
              for (int i = 0; i < pro.documents.length; i++)
                Container(
                  child: cardetails(i),
                ),
            Padding(padding: EdgeInsets.only(top: 250.0)),
            if (pro == null)
              Column(
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              )
          ],
        ),
      ),
    );
  }
  Widget cardetails(int i) {
    if (pro != null) {
      if (widget.email == pro.documents[i].data["email"]) {
        return  AnimatedCard(
              direction: AnimatedCardDirection.top, 
              initDelay: Duration(milliseconds: 0), 
              duration: Duration(seconds: 2), 
        child:Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(),
            ),
            Center(
              child:
                  Icon(Icons.directions_car, size: 150.0, color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Vehicle',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    '  Details',
                    style: TextStyle(fontSize: 40.0, color: Colors.blueAccent),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          'Car Number',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         IconButton(
                           icon: Icon(Icons.edit,size: 20.0,color: Colors.black54,), 
                           onPressed: (){
                             updateCarNo(context, pro.documents[i].documentID);
                             } 
                          ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Flexible(
                        child: Text(
                      "${pro.documents[i].data["car Number"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    )),
                  ],
                )),
               
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          'License Number',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         IconButton(
                           icon: Icon(Icons.edit,size: 20.0,color: Colors.black54,), 
                           onPressed: (){
                             updateLicNo(context, pro.documents[i].documentID);
                             } 
                          ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Flexible(
                        child: Text(
                      "${pro.documents[i].data["License"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    )),
                  ],
                )),
                Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          'Chassis Number',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         IconButton(
                           icon: Icon(Icons.edit,size: 20.0,color: Colors.black54,), 
                           onPressed: (){
                             updateChassNo(context, pro.documents[i].documentID);
                             } 
                          ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Flexible(
                        child: Text(
                      "${pro.documents[i].data["Chassis No"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    )),
                  ],
                )),

                Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          'Engine Number',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         IconButton(
                           icon: Icon(Icons.edit,size: 20.0,color: Colors.black54,), 
                           onPressed: (){
                             updateEngNo(context, pro.documents[i].documentID);
                             } 
                          ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Flexible(
                        child: Text(
                      "${pro.documents[i].data["Engine Number"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    )),
                  ],
                )),
          ],
        )
        );
      } else
        return Container();
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Future<bool> updateCarNo(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Update Car Number",
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Form(
                key: formKey,
              child: Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  width: MediaQuery.of(context).size.width*4,
                  child: ListView(children: <Widget>[
                    TextFormField(
                       controller: TextEditingController(),
                    textCapitalization: TextCapitalization.characters, 
                    inputFormatters: [MaskTextInputFormatter(mask: "## ** ## ****", filter: { "#": RegExp(r'[A-Z]') , "*":RegExp(r'[0-9]')})],
                      decoration: InputDecoration(
                        labelText: 'Car Number',
                        labelStyle:
                          TextStyle(
                            color: Colors.grey[900], 
                            fontSize: 20.0
                          ),
                          hintText: 'GJ 05 AA 0220',
                        prefixIcon: const Icon(
                        Icons.person,
                        size: 40.0,
                        color: Colors.blue,
                      ),
                     ),
                      validator: (value) =>
                       value.isEmpty ? "Car Number can't be empty" : null,
                      onChanged: (value) {
                        this._model = value;
                      },
                    ),
                  ]),
                ),
              ),
            actions: <Widget>[
              FlatButton(
                color: Colors.lightBlue[50],
                shape: RoundedRectangleBorder(
                borderRadius:new BorderRadius.circular(20.0))                                    ,
                child: Text(
                  "   Update   ",
                  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  if (validateAndSave()) {
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              car_details(email: widget.email)));
                              crudobj.updateData(selectedDoc, {
                                      'car Number': this._model,
                                  },
                                  "car_detail"
                                );
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(left:15.0)),
              FlatButton(
                color: Colors.lightBlue[50],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)),
                child: Text(
                  "   Cancel   ",
                  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

   Future<bool> updateLicNo(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Update License Number",
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Form(
                key: formKey,
              child: Container(
                  height: 200.0,
                  width: 270.0,
                  child: ListView(children: <Widget>[
                    TextFormField(
                  controller: TextEditingController(),
                    textCapitalization: TextCapitalization.characters, 
                    inputFormatters: [MaskTextInputFormatter(mask: "##** ***********", filter: { "#": RegExp(r'[A-Z]') , "*":RegExp(r'[0-9]')})],
                      decoration: InputDecoration(
                        labelText: 'License Number',
                        labelStyle:
                        TextStyle(color: Colors.grey[900], fontSize: 20.0),
                        prefixIcon: const Icon(
                        Icons.person,
                        size: 40.0,
                        color: Colors.blue,
                      ),
                     ),
                      validator: (value) =>
                       value.isEmpty ? "License Number can't be empty" : null,
                      onChanged: (value) {
                        this._model = value;
                      },
                    ),
                  ]),
                ),
              ),
            actions: <Widget>[
              FlatButton(
                color: Colors.lightBlue[50],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)),
                child: Text(
                  "   Update   ",
                  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                   if (validateAndSave()) {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            car_details(email: widget.email)));
                                crudobj.updateData(selectedDoc, {
                                      'License': this._model,
                                  },
                                  "car_detail"
                                );
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(left:15.0)),
              FlatButton(
                color: Colors.lightBlue[50],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)),
                child: Text(
                  "   Cancel   ",
                  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  Future<bool> updateChassNo(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Update Chassis Number",
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Form(
                key: formKey,
              child: Container(
                  height: 200.0,
                  width: 270.0,
                  child: ListView(children: <Widget>[
                    TextFormField(
                  controller: TextEditingController(),
                    textCapitalization: TextCapitalization.characters, 
                    inputFormatters: [MaskTextInputFormatter(mask: "##** ***********", filter: { "#": RegExp(r'[A-Z]') , "*":RegExp(r'[0-9]')})],
                      decoration: InputDecoration(
                        labelText: 'Chassis Number',
                        labelStyle:
                        TextStyle(color: Colors.grey[900], fontSize: 20.0),
                        prefixIcon: const Icon(
                        Icons.person,
                        size: 40.0,
                        color: Colors.blue,
                      ),
                     ),
                      validator: (value) =>
                       value.isEmpty ? "Chassis Number can't be empty" : null,
                      onChanged: (value) {
                        this._model = value;
                      },
                    ),
                  ]),
                ),
              ),
            actions: <Widget>[
              FlatButton(
                color: Colors.lightBlue[50],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)),
                child: Text(
                  "   Update   ",
                  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                   if (validateAndSave()) {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  car_details(email: widget.email)));
                  crudobj.updateData(selectedDoc, {
                                      'Chassis No': this._model,
                                  },
                                  "car_detail"
                                );
                }
                },
              ),
              Padding(padding: EdgeInsets.only(left:15.0)),
              FlatButton(
                color: Colors.lightBlue[50],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)),
                child: Text(
                  "   Cancel   ",
                  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  Future<bool> updateEngNo(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Update Engine Number",
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Form(
                key: formKey,
              child: Container(
                  height: 200.0,
                  width: 270.0,
                  child: ListView(children: <Widget>[
                    TextFormField(
                  controller: TextEditingController(),
                    textCapitalization: TextCapitalization.characters, 
                    inputFormatters: [MaskTextInputFormatter(mask: "#################", filter: { "#": RegExp(r'[A-Z,0-9]') })],
                      decoration: InputDecoration(
                        labelText: 'Engine Number',
                        labelStyle:
                        TextStyle(color: Colors.grey[900], fontSize: 20.0),
                        prefixIcon: const Icon(
                        Icons.person,
                        size: 40.0,
                        color: Colors.blue,
                      ),
                     ),
                      validator: (value) =>
                       value.isEmpty ? "Engine Number can't be empty" : null,
                      onChanged: (value) {
                        this._model = value;
                      },
                    ),
                  ]),
                ),
              ),
            actions: <Widget>[
              FlatButton(
                color: Colors.lightBlue[50],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)),
                child: Text(
                  "   Update   ",
                  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                   if (validateAndSave()) {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  car_details(email: widget.email)));
                  crudobj.updateData(selectedDoc, {
                                      'Engine Number': this._model,
                                  },
                                  "car_detail"
                                );
                }
                },
              ),
              Padding(padding: EdgeInsets.only(left:15.0)),
              FlatButton(
                color: Colors.lightBlue[50],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)),
                child: Text(
                  "   Cancel   ",
                  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }
}