import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:url_launcher/url_launcher.dart';
class cmp_bajaj extends StatefulWidget {
   cmp_bajaj({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _cmp_bajajState createState() => _cmp_bajajState();
}

class _cmp_bajajState extends State<cmp_bajaj> {
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child:Center(
              
              child: Text("Bajaj Allianz General Insurance",style: TextStyle(fontFamily:"Merriweather",fontSize: 20.0),),
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
                    Text("Bajaj Allianz continues to be one of the most financially robust general insurance companies in India by maintaining its growth as well as profitability.",
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
                    Text("The company has registered a net profit of Rs 780 crore.",
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
                    Text("A revenue of Rs. 11,097 crore, that has grown by 17% compared to the last fiscal year.",
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
              onPressed: () => launch("tel:1800-209-0144"),
              child: new Text("1800-209-0144",style: TextStyle(fontSize:25.0,fontWeight: FontWeight.bold),)),
             
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
  const url = "https://www.bajajallianz.com"; 
  if (await canLaunch(url)) { 
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}

