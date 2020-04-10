import 'package:animated_card/animated_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:mobilyft/Ride_Share/HomePage/car_share_home_page.dart';
class notify extends StatefulWidget {
  final String email;
  notify({Key key, this.email}) : super(key: key);
  @override
  _notifyState createState() => _notifyState();
}
class _notifyState extends State<notify> {
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot ride;
  String _src, _dest, _seat;
  @override
  void initState() {
    crudobj.getData('notify').then((result) {
      setState(() {
        ride = result;
      });
    });
  }

  int l = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        
        children: <Widget>[
          if (ride != null)
            for (int i = 0; i < ride.documents.length; i++)
              Column(
                children: <Widget>[
                  returnride(i),
                ],
              ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          if (ride == null)
            Column(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
              ],
            )
        ],
      ),
    );
  }

  Widget returnride(int i) {
    if (ride != null) {
      if (widget.email == ride.documents[i].data["email"]) {
        return Padding(
            padding: EdgeInsets.only(top: 5.0,left: 10.0,right: 5.0),
            child: AnimatedCard(
              direction: AnimatedCardDirection.right, 
              initDelay: Duration(milliseconds: 0), 
              duration: Duration(seconds: 2), 
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
                child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 50.0,
                    ),
                    title: Text(
                        "${ride.documents[i].data["notice"]}",
                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400),),
                    subtitle: Text("${ride.documents[i].data["detail"]}",
                    style: TextStyle(fontSize:15.0,fontWeight:FontWeight.w300),),
                    onLongPress: (){
                      showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                            content: SingleChildScrollView(
                              child: Center(
                                child: Text(
                                  "You Want To Delete ?",
                                  style: TextStyle(
                                    fontSize:25,
                                    fontWeight:FontWeight.w400),
                                    )
                                  ),
                            ),
                             actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "Yes",
                                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                              ),
                              onPressed: () {
                               crudobj.deleteData(ride.documents[i].documentID,"notify");
                                Navigator.pop(context,true);
                                Navigator.pop(context,true);                                
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Home_page(email: widget.email,)));
                                             
                              },
                            ),
                            Padding(padding: EdgeInsets.only(left:17.0)),
                            FlatButton(
                              child: Text(
                                "No",
                                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                              ),
                              onPressed: () {
                               Navigator.pop(context, true);
                              },
                            ),
                            Padding(padding: EdgeInsets.only(left:20.0)),
                          ]
                        );
                      }
                    );
                  },
                  )
                ),
            )
          );
      } else
        return Container( );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
