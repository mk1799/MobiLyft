import 'package:animated_card/animated_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:mobilyft/Ride_Share/Dashboard/car_share_ride_details.dart';
class allride extends StatefulWidget {
  final String email;
  allride({Key key, this.email}) : super(key: key);
  @override
  _allrideState createState() => _allrideState();
}
class _allrideState extends State<allride> {
  String _src,_dest,_time,_seat;
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot ride;
  @override
  void initState() {
    crudobj.getData('history').then((result) {
      setState(() {
        ride = result;
      });
    });
  }
int l = 0;
void insert(BuildContext context) {    
    Map<String, dynamic> data = {
      'email': widget.email,
      'source': _src,
      'dest': _dest,
      'time': _time,
      'Seat': _seat,
};
    crudobj.adddata(data, context,"current ride").then((result) {}).catchError((e) {
      print(e);
    });
  }
  void submit(int i) async {   
 _src=ride.documents[i].data["Source"]; 
 _dest=ride.documents[i].data["Destination"];
 _time=ride.documents[i].data["Time"];
 _seat=ride.documents[i].data["Seat"];  
  insert(context);
  Navigator.pop(context,true);
  Navigator.pop(context,true);
  Navigator.push(
    context,
    MaterialPageRoute(
     builder: (BuildContext context) =>
      Ride_Details(email: widget.email)
      )
   );
  } 
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
                  "Histroy Ride",
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
      if (widget.email == ride.documents[i].data["Email"]) {
        return Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: AnimatedCard(
              direction: AnimatedCardDirection.right, 
              initDelay: Duration(milliseconds: 5), 
              duration: Duration(seconds: 3), 
            child: Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 10.0),
              child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 60.0,
                    ),
                    title: Text(
                        "${ride.documents[i].data["Source"]}\tto\t${ride.documents[i].data["Destination"]}",style: TextStyle(fontSize:30.0,fontWeight: FontWeight.w400),),
                    subtitle: Text("Time : "
                        "${ride.documents[i].data["Time"]}\nSeat : ${ride.documents[i].data["Seat"]}",style: TextStyle(fontSize:20.0),),
                    onTap: () {
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
                                  fontWeight: FontWeight.bold,
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
                                            Icon(
                                              Icons.location_searching,
                                              size: 40.0,
                                            ),
                                            Icon(Icons.chevron_right),
                                            Expanded(
                                              child: Text(
                                                "${ride.documents[i].data["Source"]}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                                              ),
                                              flex: 1,
                                            )
                                          ],
                                        )
                                      ])),
                                  Padding(
                                      padding: EdgeInsets.only(top: 15.0),
                                      child: new Column(children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              size: 40.0,
                                            ),
                                            Icon(Icons.chevron_right),
                                            Expanded(
                                              child: Text(
                                                "${ride.documents[i].data["Destination"]}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                                              ),
                                              flex: 1,
                                            )
                                          ],
                                        )
                                      ])),
                                  Padding(
                                      padding: EdgeInsets.only(top: 15.0),
                                      child: new Column(children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.access_time,
                                              size: 40.0,
                                            ),
                                            Icon(Icons.chevron_right),
                                            Expanded(
                                              child: Text(
                                                "${ride.documents[i].data["Time"]}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                                              ),
                                              flex: 1,
                                            )
                                          ],
                                        )
                                      ])),
                                  Padding(
                                      padding: EdgeInsets.only(top: 15.0),
                                      child: new Column(children: <Widget>[
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
                                                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                                              ),
                                              flex: 1,
                                            )
                                          ],
                                        )
                                      ])),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                               FlatButton(
                                  child: Text(
                                    ' Re-add ',
                                    style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.w300),
                                  ),
                                  onPressed: () {
                                    submit(i);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Delete',
                                      style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.w300)),
                                  onPressed: () {
                                    //Navigator.of(context).pop();
                                    crudobj.deleteData(ride.documents[i].documentID,"all ride");
                                    Navigator.pop(context, true);
                                    Navigator.pop(context, true);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              allride(email: widget.email)));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
                  ),
                )
              )
            );
      } else
        return Container(
          
        );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
