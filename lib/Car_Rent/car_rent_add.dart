
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:nice_button/NiceButton.dart';

import 'car_rent_add_search.dart';
class rent_add extends StatefulWidget {
   final String email;
  rent_add({Key key, this.email}) : super(key: key);
  @override
  _rent_addState createState() => _rent_addState();
}
class _rent_addState extends State<rent_add> {
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  CRUD1 crudobj = new CRUD1();
  String carnum,carmodel,carSeat;
  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
  void insert(BuildContext context) {
    Map<String, dynamic> data = {
      'email': widget.email,
      'car Number': carnum,
      'car Model': carmodel,
      'seat':carSeat,
    };
    crudobj.adddata(data, context,"car rent").then((result) {}).catchError((e) {
      print(e);
    });    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key:scaffoldKey,
        body: Form(
          key: formKey,
            child: ListView(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.25,
                      width: MediaQuery.of(context).size.width*1.5,
                      child: Carousel(
                        boxFit: BoxFit.cover,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 10),
                        dotSize: 6.0,
                        dotIncreasedColor: Color(0xFFFF335C),
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.bottomCenter,
                        dotVerticalPadding: 10.0,
                        showIndicator: true,
                        indicatorBgPadding: 7.0,
                        images: [
                          Image.asset("asets/rentsearch.jpg",fit: BoxFit.fill,),
                          Image.asset("asets/caradd.jpg",fit: BoxFit.fill,),
                          Image.asset("asets/searchrent.jpg",fit: BoxFit.fill,),                        
                        ],
                      ),
                    ),
                    SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        inputFormatters: [MaskTextInputFormatter(
                          mask: "## ** ## ****",
                          filter: { "#": RegExp(r'[A-Z]') , "*":RegExp(r'[0-9]')}
                        )],
                        decoration: InputDecoration(
                          labelText: "Car Number",
                          hintText: "GJ 05 AA 0100",
                          border: OutlineInputBorder()
                          // border: InputBorder.none
                        ),
                        validator: (value) =>value.isEmpty ? "Car Number can't be empty" : null,                                                          
                        onChanged: (String value) {
                        this.carnum = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Car Model",
                          hintText: "Audi",
                          border: OutlineInputBorder()
                          // border: InputBorder.none
                        ),
                        validator: (value) =>value.isEmpty ? "Car Model can't be empty" : null,                                                          
                        onChanged: (String value) {
                        this.carmodel = value;
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Seat",
                          hintText: "2",
                          border: OutlineInputBorder()
                          // border: InputBorder.none
                        ),
                        validator: (value) =>value.isEmpty ? "Number of Seat can't be empty" : null,                                                          
                        onChanged: (String value) {
                        this.carSeat = value;
                        },
                      ),
                    ),
                  ),
                  
                  Padding(padding: EdgeInsets.only(left:20.0,right:20.0),
                    child: NiceButton(
                      text: 'Add',
                      gradientColors: [secondColor, firstColor],
                      background: Colors.transparent,
                      onPressed: (){
                        if (validateAndSave()) {
                          insert(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                              rent_addsearch(email: widget.email)
                            )
                          );
                        }
                      }
                    ),
                  ),
                ],
            ),
        ),
      )
    );
  }
}