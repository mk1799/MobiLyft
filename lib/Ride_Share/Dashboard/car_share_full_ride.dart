import 'package:flutter/material.dart';
import 'package:mobilyft/Ride_Share/Dashboard/car_share_allride.dart';
import 'package:mobilyft/Ride_Share/Dashboard/car_share_ride_details.dart';
class fullride extends StatefulWidget {
  final String email;
  fullride({Key key, this.email}) : super(key: key);
  @override
  _fullrideState createState() => _fullrideState();
}

class _fullrideState extends State<fullride> {
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
                "Ride Details",
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
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:40.0)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.width*0.9,
                child: Center(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Ride_Details(email: widget.email)
                                    )
                              );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left:70.0,right: 70.0,),
                      child: Icon(Icons.view_list,size: 130,),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)
                    ),
                  ),
                ),
              ),

              
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Current Ride',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top:30.0)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.width*0.9,
                child: Center(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          allride(email: widget.email)
                                    )
                              );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left:70.0,right: 70.0),
                      child: Icon(Icons.history,size: 130,),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)
                    ),
                  ),
                ),
              ),

            
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Ride Histroy',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
              ),
            ],
          )
        ),
      );
    }
  }
