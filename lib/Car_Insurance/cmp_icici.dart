import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:url_launcher/url_launcher.dart';
class cmp_icici extends StatefulWidget {
   cmp_icici({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _cmp_iciciState createState() => _cmp_iciciState();
}

class _cmp_iciciState extends State<cmp_icici> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child:Center(
              
              child: Text("ICICI Lombard General Insurance ",style: TextStyle(fontFamily:"Merriweather",fontSize: 20.0),),
            ),
          ),
          Padding(padding: EdgeInsets.only(top:10.0)),
          Row(
            children: <Widget>[
              Expanded(child:Column(
                children: <Widget>[
                  Icon(Icons.arrow_right),
                  
                ],
              ), ),
            
              Expanded(
                child:Column(
                  children: <Widget>[
                    Text("The company issued over 26.5 million policies and settled over 1.6 million claims as on March 31, 2019.",
                    style: TextStyle(fontSize:20.0),
                    
                    )
                  ],
                ),
                flex: 6,
              )
              
            ],
          ),
          Padding(padding: EdgeInsets.only(top:20.0)),
           Row(
            children: <Widget>[
              Expanded(child:Column(
                children: <Widget>[
                  Icon(Icons.arrow_right),
                  
                ],
              ), ),
            
              Expanded(
                child:Column(
                  children: <Widget>[
                    Text("we provide travel,two wheeler,car,health,NRI service,business insurance,home insurance.",
                    style: TextStyle(fontSize:20.0),
                    
                    )
                  ],
                ),
                flex: 6,
              )
              
            ],
          ),

           Padding(padding: EdgeInsets.only(top:20.0)),
           Row(
            children: <Widget>[
              Expanded(child:Column(
                children: <Widget>[
                  Icon(Icons.arrow_right),
                  
                ],
              ), ),
            
              Expanded(
                child:Column(
                  children: <Widget>[
                    Text("In India with a Gross Written Premium (GWP) of Rs147.89 billion for the year ended March 31, 2019.",
                    style: TextStyle(fontSize:20.0),
                    
                    )
                  ],
                ),
                flex: 6,
              )
              
            ],
          ),


           Padding(padding: EdgeInsets.only(top:20.0)),
           Row(
            children: <Widget>[
              Expanded(child:Column(
                children: <Widget>[
                  Icon(Icons.arrow_right),
                  
                ],
              ), ),
            
              Expanded(
                child:Column(
                  children: <Widget>[
                    Text("We give upo 70% insurance.",
                    style: TextStyle(fontSize:20.0,),
                    textAlign: TextAlign.left,
                    
                    )
                  ],
                ),
                flex: 6,
              ),

              
              Padding(padding: EdgeInsets.only(right:80.0)),
              
            ],
          ),
          

          Padding(padding: EdgeInsets.only(top:20.0)),
           Row(
            children: <Widget>[
              Expanded(child:Column(
                children: <Widget>[
                  Icon(Icons.call),
                  
                ],
              ), ),
            
              Expanded(
                child:Column(
                  children: <Widget>[
                     FlatButton(
              onPressed: () => launch("tel:1800 2666"),
              child: new Text("1800 2666",style: TextStyle(fontSize:25.0,fontWeight: FontWeight.bold),)),
             
                  ],
                ),
                flex: 6,
              ),

              
              Padding(padding: EdgeInsets.only(right:130.0)),
              
            ],
          ),




          Padding(padding: EdgeInsets.only(top:40.0,left:20.0,right:20.0)),
          Row(
            children: <Widget>[
            Padding(padding: EdgeInsets.only(left:40.0)),
             NiceButton(
               text: "Buy Insurance",
               fontSize: 30.0,
               textColor: Colors.black,
               onPressed: _launchURL,
                              gradientColors: [Colors.blue,Colors.white],
                              background: null,
                            ),

        
                            
                           ],
                         ),

                         
                           
               
                       ],
                     ),
               
                   );
                   
                 }
               
                 _launchURL() async {
  const url = "https://www.icicilombard.com"; 
  if (await canLaunch(url)) { 
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}

