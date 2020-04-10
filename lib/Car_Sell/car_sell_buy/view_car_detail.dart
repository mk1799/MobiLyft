import 'package:animated_card/animated_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
class view_sell_car_detail extends StatefulWidget {
  view_sell_car_detail({Key key,
      this.email,this.name,this.company,this.model,
      this.year,this.fuel,this.gear,this.color,this.carnum,this.km,this.price,this.add
    }) : super(key: key);
  final String email,name,company,model,year,fuel,gear,color,carnum,km,price,add;
  @override
  _view_sell_car_detailState createState() => _view_sell_car_detailState();
}

class _view_sell_car_detailState extends State<view_sell_car_detail> {
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot pro,user;
  String namecr;
  @override
  void initState() {
    crudobj.getData('sell car').then((result) {
      setState(() {
        pro = result;
      });
    });
     crudobj.getData('user').then((result) {
      setState(() {
        user = result;
      });
    });
  }

  int l = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
      )
    );
  }
   Widget cardetails(int i){
    if(pro!=null){
      if (widget.email == pro.documents[i].data["email"]) 
      if (widget.company == pro.documents[i].data["car Manufacturer Company"]) 
      if (widget.model == pro.documents[i].data["car Model"]) 
      if (widget.year == pro.documents[i].data["car Registration Year"]) 
      if (widget.fuel == pro.documents[i].data["car fuel type"]) 
      if (widget.gear == pro.documents[i].data["car gear type"]) 
      if (widget.color == pro.documents[i].data["car color"]) 
      if (widget.carnum == pro.documents[i].data["car number"])
      if (widget.km == pro.documents[i].data["km of use"])
      if (widget.price == pro.documents[i].data["car price"])
      if (widget.add == pro.documents[i].data["Address person"]) 
      {
        return Padding(padding: EdgeInsets.only(top:10.0,left:10.0,right: 10.0,),
          child: AnimatedCard(
              direction: AnimatedCardDirection.top, 
              initDelay: Duration(milliseconds: 5), 
              duration: Duration(seconds: 3),
              child: Column(
                children: <Widget>[
                  Padding(
                  padding: EdgeInsets.only(top:10.0),
                  child:SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.11,
                    child: Icon(Icons.directions_car,
                      size: 80.0,
                      color: Colors.blue[700],
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(top:5.0),
                  child:SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,             
                    child:Center(
                      child: RichText(
                        text:TextSpan(
                          text:'Car',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.black
                          ),
                          children: <TextSpan>[
                            TextSpan(text: ' Detail', 
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.blue,
                                fontSize: 40
                              )
                            )
                          ]
                        ),
                      ),
                    )
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),


                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Company",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["car Manufacturer Company"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),

                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Model",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["car Model"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),

                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Buy Year",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["car Registration Year"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),

                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Fuel Type",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["car fuel type"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),

                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Gear Type",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["car gear type"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),

                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Color",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["car color"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),

                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Car Number",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["car number"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),

                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Use",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["km of use"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),

                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Price",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["car price"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),

                Divider(),
                Padding(padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right:15.0)),
                      Column(
                        children: <Widget>[
                          Text("Address",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ], 
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${pro.documents[i].data["Address person"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        flex: 3,
                      ),                 
                    ],
                  ),
                ),
                Divider(),
                
                
                
              ],
            )
          ),
        );
      } 
    }
  }

}