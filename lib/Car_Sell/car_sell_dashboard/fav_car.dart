import 'package:animated_card/animated_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobilyft/Car_Sell/car_sell_home.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:nice_button/NiceButton.dart';
class fav_car extends StatefulWidget {
  fav_car({Key key, this.email}) : super(key: key);
  final String email;
  @override
  _fav_carState createState() => _fav_carState();
}
class _fav_carState extends State<fav_car> {
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  QuerySnapshot fav,cars,user;
  CRUD1 crudobj = new CRUD1();
  int l = 0;
  String _ccomapny,_cmodel,_cprice,_cyear,_ccolor,_cfuel,_cgear,_cnumber,_cadd,emailcr,namecr;
  void insert(BuildContext context) {
    Map<String, dynamic> data = {
      'Emailreq': widget.email,
      'Emailcr' : emailcr,
      'Namecr' : namecr,
      'Car Company' : _ccomapny,
      'Car Model' : _cmodel,
      'car price':_cprice,
      'car Registration Year':_cyear,
      'car color':_ccolor,
      'car gear type':_cgear,
      'car fuel type':_cfuel,
      'Address person':_cadd,
      'Contact number':_cnumber     
    };
    crudobj.adddata(data, context,"interest request").then((result) {}).catchError((e) {
      print(e);
      }
    );  
}
void submit(int i) async { 
 namecr=user.documents[i].data["name"];
 emailcr=cars.documents[i].data["email"];
 _ccomapny=cars.documents[i].data["car Manufacturer Company"];
 _cmodel=cars.documents[i].data["car Model"];
 _cprice=cars.documents[i].data["car price"];
 _cyear=cars.documents[i].data["car Registration Year"];
 _ccolor=cars.documents[i].data["car color"];
 _cgear=cars.documents[i].data["car gear type"];
 _cfuel=cars.documents[i].data["car fuel type"];
 _cadd=cars.documents[i].data["Address person"];
 _cnumber=cars.documents[i].data["Contact number"];
  insert(context);
  crudobj.deletefavcar(fav.documents[i].documentID); 
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => fav_car(email: widget.email)
        )
      );
    }
  @override
  void initState() {
    crudobj.getData('car fav').then((result) {
      setState(() {
        fav = result;
      });
    });
     crudobj.getData('sell car').then((result) {
      setState(() {
        cars = result;
      });
    });
    crudobj.getData('user').then((result) {
      setState(() {
        user = result;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Fav Car List",
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
      body: ListView(
        children: <Widget>[
          if (fav != null)
            for (int i = 0; i < fav.documents.length; i++)
              Column(
                children: <Widget>[
                  returnfav(i),
                ],
              ),
          Padding(padding: EdgeInsets.only(top: 250.0)),
          if (fav == null)
            Column(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
              ],
            )
        ],
      ),

    );
  }
  Widget returnfav(int i) {
    if (fav != null) {
      if (widget.email == fav.documents[i].data["Emailreq"]) {
        return Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: AnimatedCard(
              direction: AnimatedCardDirection.right, 
              initDelay: Duration(milliseconds: 0), 
              duration: Duration(seconds: 2), 
              child: Padding(
                padding: const EdgeInsets.only(left:20.0,right:20.0,top: 20.0,bottom: 20.0),
                child: Card(
                   child: ListTile(
                     title: Container(
                       height: 250.0,
                       child: Column(
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: Column(
                               children: <Widget>[
                                 Row(
                                   children: <Widget>[
                                     Expanded(
                                child: Text(
                                      "Car Company",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w500),
                                     ),    
                                ),                               
                                 Expanded(
                                child: Text(
                                 "${fav.documents[i].data["Car Company"]}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                                    ), 
                                    flex: 1,             
                                  )
                                   ]
                                 ),
                                 Padding(padding: EdgeInsets.only(top: 5.0),),
                               Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Car Model",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500),
                                 ),
                                   
                                ),
                               
                              Expanded(
                                child: Text(
                                 "${fav.documents[i].data["Car Model"]}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                                    ), 
                                    flex: 1,             
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 5.0),),
                              Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Car Price",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500),
                                 ),
                                   
                                ),
                                
                              Expanded(
                                child: Text(
                                 "${fav.documents[i].data["car price"]}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                                    ),
                                    flex: 1,              
                                  )
                                ],
                              )                               
                            ],
                          )
                        ),                    
                       Padding(
                         padding: const EdgeInsets.only(top:15.0),
                           child: NiceButton(
                             onPressed: (){
                               submit(i);
                             },
                             text: "Intrest",
                             gradientColors: [secondColor, firstColor],
                             background: null,
                             )
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top:15.0),
                             child: NiceButton(
                               onPressed: (){
                                 crudobj.deletefavcar(fav.documents[i].documentID);                                
                                Navigator.pop(context, true);                                
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            fav_car(email: widget.email,)));
                                  },
                               text: "Remove",
                               gradientColors: [secondColor, firstColor],
                               background: null,
                             )
                           ),
                               
                             ],
                           ),
                        
                      
                     ),
                     onTap: (){
                       emailcr = cars.documents[i].data["email"];
                    print(emailcr);
                     for (int i = 0; i < user.documents.length; i++)
                      if(emailcr == user.documents[i].data["email"])
                      {
                       namecr= user.documents[i].data["name"];
                      }
                      showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.all(Radius.circular(10.0))),
                            title: Center(
                            child: Text(
                              'Car Details',
                              style: TextStyle(
                                fontFamily: 'helvetica_neue_light',
                                fontWeight: FontWeight.w500,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Name",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              namecr,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                    Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Company",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["car Manufacturer Company"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                     Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Model",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["car Model"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                     Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Buy",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["car Registration Year"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                     Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Fuel Type",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["car fuel type"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                    Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Gear Type",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["car gear type"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                     Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Color",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["car color"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                     Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Seat",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["car seat"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),
                                  
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Car Number",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["car number"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                    Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "KM Of Used",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["km of use"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                    Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Price",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "Rs.""${cars.documents[i].data["car price"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),

                                    Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Address",
                                              // 'Destination'
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            flex: 1,
                                          ),
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${cars.documents[i].data["Address person"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                                            ),
                                            
                                          )
                                        ],
                                      )
                                    ])),
                              ],
                            ),
                          ),

                        );
                      }
                       );
                   
                     },
            ),
            
                ),
                
              )
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
}