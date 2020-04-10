import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:url_launcher/url_launcher.dart';
class cmp_royal extends StatefulWidget {
   cmp_royal({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _cmp_royalState createState() => _cmp_royalState();
}

class _cmp_royalState extends State<cmp_royal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child:Center(
              
              child: Text("Royal Sundaram General Insurance",style: TextStyle(fontFamily:"Merriweather",fontSize: 20.0),),
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
                    Text("We Have over 2000 employees with 150 branches across India.",
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
                    Text("We provide car, Health, Personal Accident, Home and Travel Insurance.",
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
                    Text("Today we have around 4.5 million Happy customers across India. ",
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
                    Text("We give upo 50% insurance.",
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
              onPressed: () => launch("tel:1860 425 0000"),
              child: new Text("1860 425 0000",style: TextStyle(fontSize:25.0,fontWeight: FontWeight.bold),)),
             
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
  const url = "https://www.royalsundaram.in"; 
  if (await canLaunch(url)) { 
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}

