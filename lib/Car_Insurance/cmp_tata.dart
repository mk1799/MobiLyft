import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:url_launcher/url_launcher.dart';
class cmp_tata extends StatefulWidget {
   cmp_tata({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _cmp_tataState createState() => _cmp_tataState();
}

class _cmp_tataState extends State<cmp_tata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child:Center(
              
              child: Text("Tata AIG General Insurance",style: TextStyle(fontFamily:"Merriweather",fontSize: 20.0),),
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
                    Text("Tata AIG General Insurance Company Limited celebrates 18 years of service this year (2019) since it commenced operations in India on January 22, 2001.",
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
                    Text("We Provide insurance for Liability, Marine Cargo, Personal Accident, Travel, Rural-Agriculture Insurance, Extended Warranty etc.",
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
                    Text("With more than 200 offices spread across India, the Company has a robust multi-channel distribution network of 22,000+ licensed agents and 390+ licensed brokers.",
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
                    Text("The Company has a workforce of over 5,000 employees, including 550+ claim experts.",
                    style: TextStyle(fontSize:20.0,),
                    textAlign: TextAlign.left,
                    
                    )
                  ],
                ),
                flex: 6,
              ),
              
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
              onPressed: () => launch("tel:1800 266 7780"),
              child: new Text("1800 266 7780",style: TextStyle(fontSize:25.0,fontWeight: FontWeight.bold),)),
             
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
  const url = "https://www.tataaig.com"; 
  if (await canLaunch(url)) { 
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}

