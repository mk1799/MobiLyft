import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobilyft/Crud_File/crud1.dart';

import 'map.dart';


class car_service extends StatefulWidget {
  final String email;
  car_service({Key key,this.email}) : super(key: key);

  @override
  _CrRideState createState() => _CrRideState();
}

class _CrRideState extends State<car_service> {
 String email,model,number,seat;
 CRUD1 crudobj = new CRUD1();
  QuerySnapshot ride;
  @override
  void initState() {
    crudobj.getData('Garage List').then((result) {
      setState(() {
        ride = result;
      });
    });
  }

  int l = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
    );
  }


  Widget returnride(int i) {
    double lat=ride.documents[i].data["lat"];
    double long=ride.documents[i].data["long"];
    if (ride != null) {
        return Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Card(
                color: Colors.lightBlue[50],
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 50.0,
                  ),
                  title: Text(
                      "${ride.documents[i].data["Name"]}",style: TextStyle(fontSize: 20.0),),
                  subtitle: Text("Phone : "
                      "${ride.documents[i].data["Phone"]}\nLoc. : ${ride.documents[i].data["Address"]}", style: TextStyle(fontSize: 15.0),),
              trailing: IconButton(
                    icon: Icon(Icons.map),
                    onPressed:() {//openMapsSheet(context,lat,long);
                    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>map_launch()));}
                  ),
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Center(
                                child: Text(
                                  'Want to Get Service?',
                                  style: TextStyle(
                                    fontFamily: 'helvetica_neue_light',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                              
                              actions: <Widget>[
                               
                                FlatButton(
                                  child: Text('    Yes    ',
                                      style: TextStyle(fontSize: 20.0)),
                                  onPressed: () {
                                    //Navigator.of(context).pop();
                                    Navigator.pop(context, true);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Cancel',
                                      style: TextStyle(fontSize: 20.0)),
                                  onPressed: () {
                                    
                                    Navigator.pop(context, true);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ));
    }
     else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
 Future openMapsSheet(context,lat,long) async {
    try {
      final title = "Shanghai Tower";
      final description = "Asia's tallest building";
      final coords = Coords(lat, long);
      final availableMaps = await MapLauncher.installedMaps;

      print(availableMaps);

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                          description: description,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}