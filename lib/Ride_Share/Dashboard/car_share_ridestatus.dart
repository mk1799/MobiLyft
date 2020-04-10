import 'package:animated_card/animated_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:url_launcher/url_launcher.dart';

class Ride_status extends StatefulWidget {
  Ride_status({Key key, this.email}) : super(key: key);
  final String email;
  @override
  _Ride_statusState createState() => _Ride_statusState();
}

class _Ride_statusState extends State<Ride_status> {
  CRUD1 crudobj = new CRUD1();
  int l = 0;
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  String requester, namereq, phonereq;
  QuerySnapshot req, user, respo;
  String _code;
  @override
  void initState() {
    crudobj.getData('ride request').then((result) {
      setState(() {
        req = result;
      });
    });
    // print(req.documents[0].data["Emailcr"]);
    crudobj.getData('user').then((result) {
      setState(() {
        user = result;
      });
    });

    crudobj.getData('ride request response').then((result) {
      setState(() {
        respo = result;
      });
    });
  }

  void testcode(int i) {
    print(_code);
    if (_code == respo.documents[i].data["Otp"].toString()) {
      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text("Verified!!",
                            style: TextStyle(
                                fontSize: 35.0, fontWeight: FontWeight.w400)),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Enjoy Your Ride..",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                      ),
                     
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: NiceButton(
                            text: "Ok",
                            gradientColors: [secondColor, firstColor],
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            background: null,
                          )),
                    ],
                  ),
                ),
              ),
            );
          });
    }
    else{
      showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child:Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(top:15.0),
                                    child: Text("!! Not Match !!",
                                    style:TextStyle(fontSize: 35.0,fontWeight:FontWeight.w400)),
                                  ),
                                  Divider(),
                                  Padding(padding: EdgeInsets.only(top:10.0),
                                   child: Text("Please Enter Correct Code",
                                   style: TextStyle(fontSize:30.0,fontWeight:FontWeight.w700),),
                                  ),
                                
                                  Padding(padding: EdgeInsets.only(top:20.0),
                                  child:NiceButton(
                                    text: "Ok",
                                    gradientColors: [secondColor, firstColor],
                                    onPressed: (){
                                      Navigator.pop(context, true);
                                    },
                                    background: null,
                                  )
                                  ),
                                ],
                              ),                                                     
                            ),                           
                          ),
                        );
                      }
                   );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          if (respo != null)
            for (int i = 0; i < respo.documents.length; i++)
              Column(
                children: <Widget>[
                  returnrespo(i),
                ],
              ),
          Padding(padding: EdgeInsets.only(top: 250.0)),
          if (req == null)
            Column(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
              ],
            )
        ],
      ),
    );
  }

  Widget returnrespo(int i) {
    if (req != null) {
      if (widget.email == respo.documents[i].data["Emailcr"]) {
        requester = respo.documents[i].data["Emailreqs"];

        if (user != null) {
          for (int i = 0; i < user.documents.length; i++) {
            if (requester == user.documents[i].data["email"]) {
              namereq = user.documents[i].data["name"];

              phonereq = user.documents[i].data["phone"];
            }
          }
        }
        return Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              left: 10.0,
              right: 10.0,
            ),
            child: AnimatedCard(
                direction: AnimatedCardDirection.right,
                initDelay: Duration(milliseconds: 0),
                duration: Duration(seconds: 2),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 60.0,
                      ),
                      title: Text(
                        "$namereq"
                        "\t"
                        "Ready to Share Ride From"
                        "\t"
                        "${respo.documents[i].data["Source"]}"
                        "\t"
                        "To"
                        "\t"
                        "${respo.documents[i].data["Destination"]}"
                        "\n"
                        "Time:-"
                        "\t"
                        "${respo.documents[i].data["Time"]}",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w300),
                      ),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0, bottom: 15.0, right: 50.0),
                          child: NiceButton(
                            onPressed: () {
                              // push(context, Invite(randomNum: rNum));
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15.0),
                                                child: Text("Enter Ride Code",
                                                    style: TextStyle(
                                                        fontSize: 35.0,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ),
                                              Divider(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 15.0, bottom: 10.0),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: ' Code',
                                                    labelStyle: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontSize: 20.0),
                                                    prefixIcon: const Icon(
                                                      Icons.fiber_pin,
                                                      size: 40.0,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  validator: (value) => value
                                                          .isEmpty
                                                      ? "Seat can't be empty"
                                                      : null,
                                                  onChanged: (value) {
                                                    this._code = value;
                                                  },
                                                ),
                                              ),
                                              NiceButton(
                                                text: "Ok",
                                                gradientColors: [
                                                  secondColor,
                                                  firstColor
                                                ],
                                                onPressed: () {
                                                  
                                                  Navigator.pop(context, true);
                                                  testcode(i);
                                                },
                                                background: null,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            text: "Get Start",
                            gradientColors: [secondColor, firstColor],
                            background: null,
                          )),
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                  'Requester Details',
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
                                                Icons.person,
                                                // location_on
                                                size: 40.0,
                                              ),
                                              Icon(Icons.chevron_right),
                                              Expanded(
                                                child: Text(
                                                  namereq,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      fontWeight:
                                                          FontWeight.w300),
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
                                                Icons.email,
                                                size: 40.0,
                                              ),
                                              Icon(Icons.chevron_right),
                                              Expanded(
                                                child: Text(
                                                  "${respo.documents[i].data["Emailreqs"]}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      fontWeight:
                                                          FontWeight.w300),
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
                                                Icons.call,
                                                size: 40.0,
                                              ),
                                              Icon(Icons.chevron_right),
                                              FlatButton(
                                                  onPressed: () =>
                                                      launch("tel:$phonereq"),
                                                  child: new Text(
                                                    "$phonereq",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 25.0,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  )),
                                            ],
                                          )
                                        ])),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ))));
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