
import 'package:flutter/material.dart';
import 'package:mobilyft/Car_Rent/Car_Rent_Add_Search/car_rent_add.dart';
class rent_addsearch extends StatefulWidget {
  final String email;
  rent_addsearch({Key key, this.email}) : super(key: key);
  @override
  _rent_addsearchState createState() => _rent_addsearchState();
}

class _rent_addsearchState extends State<rent_addsearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
  new GestureDetector(
        onTap: (){  
             Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              rent_add(email: widget.email))); 
        },
        child: new Container(
          width: 310.0,
          height: 160.0, 
          child: Image.asset("asets/caradd.jpg",height: 160.0,width: 310.0,fit: BoxFit.fill,),
        )
    ),

     SizedBox(
          height: 10.0,
              ),
                  Text("Add Rent Car",style: TextStyle(
                              fontSize: 50.0, 
                              fontFamily: "Horizon"
                          ),),

Padding(padding: EdgeInsets.only(top:30.0)),
  
new GestureDetector(
        onTap: (){   
        },
        child: new Container(
          width: 310.0,
          height: 160.0, 
          child: Image.asset("asets/searchrent.jpg",height: 160.0,width: 310.0,fit: BoxFit.fill,),
        )
    ),

     SizedBox(
          height: 10.0,
              ),
                  Text("Search Rent Car",style: TextStyle(
                              fontSize: 50.0, 
                              fontFamily: "Horizon"
                          ),),
                ],
              ),
            ),
          ],
        ));
  }
}