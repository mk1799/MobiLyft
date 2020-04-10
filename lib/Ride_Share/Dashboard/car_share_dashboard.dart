import 'package:flutter/material.dart';
import 'package:mobilyft/Ride_Share/Dashboard/car_share_cardetails.dart';
import 'package:mobilyft/Ride_Share/Dashboard/car_share_full_ride.dart';
import 'car_share_ridestatus.dart';
class Dashboard extends StatefulWidget {
  final String email;
  Dashboard({Key key, this.email}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top:20.0)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.15,
                width: MediaQuery.of(context).size.width*0.9,
                child: Center(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          fullride(email: widget.email)
                                    )
                              );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70.0,right:70.0),
                      child: Icon(Icons.view_list,size: 100,),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)
                    ),
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top:10.0)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Ride Details',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
              ),


              SizedBox(
                height: MediaQuery.of(context).size.height*0.15,
                width: MediaQuery.of(context).size.width*0.9,
                child: Center(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          car_details(email: widget.email)
                                    )
                              );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70.0,right: 70.0),
                      child: Icon(Icons.directions_car,size: 100,),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)
                    ),
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top:10.0)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Vehicle Details',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height*0.15,
                width: MediaQuery.of(context).size.width*0.9,
                child: Center(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Ride_status(email: widget.email)
                                    )
                              );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left:70.0,right: 70.0),
                      child: Icon(Icons.info,size: 100,),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)
                    ),
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top:10.0)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Ride Status',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
              ),
            ],
          )
        );
      } 
    }
