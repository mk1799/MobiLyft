import 'package:animated_card/animated_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:mobilyft/Ride_Share/Dashboard/view_ride.dart';
class Ride_Details extends StatefulWidget {
  final String email;
  Ride_Details({Key key, this.email}) : super(key: key);
  @override
  _Ride_DetailsState createState() => _Ride_DetailsState();
}
class _Ride_DetailsState extends State<Ride_Details> {
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot ride,all;
  final formKey = GlobalKey<FormState>();
  int flag=0;
  DateTime now = DateTime.now();
  String formattedDate = DateFormat.yMMMMd("en_US").format(DateTime.now());
  String _src, _dest, _seat,_time,src;
  @override
  void initState() {
    crudobj.getData('current ride').then((result) {
      setState(() {
        ride = result;
      });
    });
    crudobj.getData('all ride').then((result) {
      setState(() {
        all = result;
      });
    });
  }


  

  Future<bool> alert(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Center(              
                child: Text(
                  "Select Time First!!",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        );
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
                  "Current Ride",
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
            if (ride != null)
              for (int i = 0; i < ride.documents.length; i++)
                Column(
                  children: <Widget>[
                    returnride(i),
                  ],
                ),
                if(flag==0)                   
                Container(
                  child:Text(
                    "No data!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:25.0
                    ),
                  ),                          
                ), 
            Padding(padding: EdgeInsets.only(top: 250.0)),
            if (ride == null)
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

  

  Widget returnride(int i) {
    if (ride != null) {
      if (widget.email == ride.documents[i].data["email"]) {
        flag=1;
        return Padding(
            padding: EdgeInsets.only(left:10.0,right: 10.0,top: 10.0),
            child: AnimatedCard(
              direction: AnimatedCardDirection.right, 
              initDelay: Duration(milliseconds: 5), 
              duration: Duration(seconds: 3), 
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 60.0,
                      ),
                      title: Text(
                        "${ride.documents[i].data["source"]}\tto\t${ride.documents[i].data["dest"]}",
                        style: TextStyle(
                          fontSize:30.0,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      subtitle: Text("Time : "
                        "${ride.documents[i].data["time"]}\nSeat : ${ride.documents[i].data["Seat"]}",
                        style: TextStyle(
                          fontSize:20.0
                        ),
                      ),
                      onTap: () {
                        //  Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (BuildContext context) =>
                        //                     view_ride(
                        //                       email: widget.email, 
                        //                       src:ride.documents[i].data["source"],
                        //                       dest:ride.documents[i].data["dest"],
                        //                       time:ride.documents[i].data["time"] ,
                        //                       seat:ride.documents[i].data["Seat"],
                        //                     )
                        //               )
                        //             );


                        showDialog<void>(
                          context: context,
                          barrierDismissible: true, // user must tap button!
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Center(
                                child: Text(
                                  'Ride Details',
                                  style: TextStyle(
                                    fontFamily: 'helvetica_neue_light',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30.0,
                                  ),
                                ),
                              ),
                              
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top:10.0)),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    new Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_searching,
                                              size: 40.0,
                                            ),                                             
                                            Icon(Icons.chevron_right),
                                            Expanded(
                                              child: Text(
                                                "${ride.documents[i].data["source"]}",
                                                textAlign: TextAlign.start,
                                                style:
                                                  TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight: FontWeight.w300
                                                  ),
                                                ),
                                              flex: 1,
                                            ),
                                          ],
                                        )
                                      ]
                                    ),

                                    Padding(padding: EdgeInsets.only(top:10.0)),

                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              size: 40.0,
                                            ),                                             
                                            Icon(Icons.chevron_right),
                                            Expanded(
                                              child: Text(
                                                "${ride.documents[i].data["dest"]}",
                                                textAlign: TextAlign.start,
                                                style:TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w300
                                                ),                                                 
                                              ),
                                              flex: 1,
                                            ),

                                          ],
                                        )
                                      ]
                                    ),

                                    Padding(padding: EdgeInsets.only(top:10.0)),

                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.access_time,
                                              size: 40.0,
                                            ),                                             
                                            Icon(Icons.chevron_right),
                                            Expanded(
                                              child: Text(
                                                "${ride.documents[i].data["time"]}",
                                                textAlign: TextAlign.start,
                                                style:TextStyle(                                                 
                                                    fontSize: 22.0,
                                                    fontWeight: FontWeight.w300
                                                ),
                                              ),
                                                flex: 1,
                                            )
                                          ],
                                        )
                                      ]
                                    ),

                                    Padding(padding: EdgeInsets.only(top:10.0)),

                                    Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.airline_seat_recline_normal,
                                            size: 40.0,
                                          ),                                          
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              "${ride.documents[i].data["Seat"]}",
                                              textAlign: TextAlign.start,
                                              style:TextStyle(                                                
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w300
                                              ),
                                            ),
                                              flex: 1,
                                          )
                                        ],
                                      )
                                    ]
                                  ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('View Ride',
                                      style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.w300)),
                                  onPressed: () {
                                    //  Navigator.pop(context, true);
                                    //  Navigator.pop(context, true);
                                    Navigator.pop(context, true);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                            view_ride(
                                              email: widget.email, 
                                              src:ride.documents[i].data["source"],
                                              dest:ride.documents[i].data["dest"],
                                              time:ride.documents[i].data["time"] ,
                                              seat:ride.documents[i].data["Seat"],
                                            )
                                      )
                                    );
                                  }
                                ),
                                    
                                FlatButton(
                                  child: Text('Delete',
                                      style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.w300)),
                                  onPressed: () {
                                    crudobj.deleteData(ride.documents[i].documentID,"current ride");                                      
                                    Navigator.pop(context, true);
                                    Navigator.pop(context, true);                                   
                                    Navigator.pop(context, true);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Ride_Details(email: widget.email)
                                      )
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    )
                  )
                )
              );
            } 
          else
            return Container();
          } 
          else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

