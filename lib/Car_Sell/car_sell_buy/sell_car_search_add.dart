import 'package:flutter/material.dart';
import 'package:mobilyft/Car_Sell/car_sell_buy/car_buy.dart';
import 'package:mobilyft/Car_Sell/car_sell_buy/sell_car.dart';
import 'package:mobilyft/Car_Sell/car_sell_home.dart';
class car_add_search extends StatefulWidget {
  car_add_search({Key key, this.email}) : super(key: key);
  final String email;
  @override
  _car_add_searchState createState() => _car_add_searchState();
}

class _car_add_searchState extends State<car_add_search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 160.0,
                      width: 310.0,
                      child: RaisedButton(
                          color: Colors.white,
                          child: Icon(Icons.directions_car,size:140.0),
                          onPressed: () {
                           
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              car_sell(email: widget.email)));
                
                          },
                          shape: CircleBorder(),
                        )
                      ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Sell Car",
                    style: TextStyle(color: Colors.black54, fontSize: 30.0,fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                        height: 160.0,
                        width: 310.0,
                        child: RaisedButton(
                            color: Colors.white,
                            child: Icon(Icons.search,size: 140.0,),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          buy_car_search(email: widget.email)));
                            },
                            shape: CircleBorder(),)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Buy Car",
                    style: TextStyle(color: Colors.black54, fontSize: 30.0,fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}