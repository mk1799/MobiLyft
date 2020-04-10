import 'package:flutter/material.dart';
import 'package:mobilyft/Car_Insurance/cmp_bajaj.dart';
import 'package:mobilyft/Car_Insurance/cmp_icici.dart';
import 'package:mobilyft/Car_Insurance/cmp_royal.dart';
import 'package:mobilyft/Car_Insurance/cmp_tata.dart';
import 'package:mobilyft/Car_Insurance/cmp_uii.dart';
class insurance_company extends StatefulWidget {
  insurance_company({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _insurance_companyState createState() => _insurance_companyState();
}

class _insurance_companyState extends State<insurance_company> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          
          
          body: Container(
             decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.white,Colors.lightBlue])),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110.0,
                        width: 290.0,
                        child: RaisedButton(
                              color: Colors.white,
                              child: Image.asset('asets/bajajallianz.png'),
                              onPressed: (){
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            cmp_bajaj(
                                              email: widget.email,
                                            )));
                              }
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top:10.0)),
                      SizedBox(
                        height:30.0,
                        child: Text(
                          "Bajaj Allianz General Insurance ",style: TextStyle(fontSize:22.0,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

             
                                           
                Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110.0,
                        width: 290.0,
                        child: RaisedButton(
                              color: Colors.white,
                              child: Image.asset('asets/icici.PNG',width: 250,),
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            cmp_icici(
                                              email: widget.email,
                                            )));
                              },
                                                    ),
                                                  ),
                                                  Padding(padding: EdgeInsets.only(top:10.0)),
                                                  SizedBox(
                                                    height:30.0,
                                                    child: Text(
                                                      "ICICI Lombard General Insurance ",style: TextStyle(fontSize:22.0,fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),


                Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110.0,
                        width: 290.0,
                        child: RaisedButton(
                              color: Colors.white,
                              child: Image.asset('asets/royalsundaram.png',),
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            cmp_royal(
                                              email: widget.email,
                                            )));
                              },
                                                    ),
                                                  ),
                                                  Padding(padding: EdgeInsets.only(top:10.0)),
                                                  SizedBox(
                                                    height:30.0,
                                                    child: Text(
                                                      "Royal Sundaram General Insurance ",style: TextStyle(fontSize:22.0,fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),



                Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110.0,
                        width: 290.0,
                        child: RaisedButton(
                              color: Colors.white,
                              child: Image.asset('asets/tata.png',),
                              onPressed: (){
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            cmp_tata(
                                              email: widget.email,
                                            )));
                              },
                                                    ),
                                                  ),
                                                  Padding(padding: EdgeInsets.only(top:10.0)),
                                                  SizedBox(
                                                    height:30.0,
                                                    child: Text(
                                                      "Tata AIG General Insurance",style: TextStyle(fontSize:22.0,fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),


                                            Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110.0,
                        width: 290.0,
                        child: RaisedButton(
                              color: Colors.white,
                              child: Image.asset('asets/uiic.png',),
                              onPressed: (){
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            cmp_uii(
                                              email: widget.email,
                                            )));
                              },
                                                    ),
                                                  ),
                                                  Padding(padding: EdgeInsets.only(top:10.0)),
                                                  SizedBox(
                                                    height:30.0,
                                                    child: Text(
                                                      "United India Insurance",style: TextStyle(fontSize:22.0,fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            



                              
                                          ]
                                    ),
          ),
                                );
                              
                                              
                              }
}