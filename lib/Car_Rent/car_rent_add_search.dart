import 'package:flutter/material.dart';
import 'package:mobilyft/Car_Rent/car_rent_add.dart';

import 'car_rent_search.dart';

class rent_addsearch extends StatefulWidget {
  final String email;
  rent_addsearch({Key key, this.email}) : super(key: key);
  @override
  _rent_addsearchState createState() => _rent_addsearchState();
}

class _rent_addsearchState extends State<rent_addsearch> {
  bool size = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => rent_add(
                                      email: widget.email,
                                    )));
                      },
                      child: Icon(Icons.directions_car, size: 130),
                      color: Colors.white,
                      shape: CircleBorder()),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('Add Rent Car',
                    style: TextStyle(
                        fontSize: (size) ? 30 : 30,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.55,
              child: Center(
                  child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => showrent(
                                email: widget.email,
                              )));
                },
                child: Icon(
                  Icons.search,
                  size: 150,
                ),
                shape: CircleBorder(),
                color: Colors.white,
              )),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('Search Rent Car',
                    style: TextStyle(
                        fontSize: (size) ? 30 : 30,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
