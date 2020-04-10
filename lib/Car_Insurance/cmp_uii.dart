import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:url_launcher/url_launcher.dart';
class cmp_uii extends StatefulWidget {
   cmp_uii({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _cmp_uiiState createState() => _cmp_uiiState();
}

class _cmp_uiiState extends State<cmp_uii> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child:Center(
              
              child: Text("United India Insurance",style: TextStyle(fontFamily:"Merriweather",fontSize: 20.0),),
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
                    Text("United India Insurance was incorporated as a Company on 18th February 1938. General Insurance Business in India was nationalized in 1972.",
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
                    Text("After Nationalization United India has grown by leaps and bounds and has over 14000 work force spread across 2275 offices in india.",
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
                    Text("We are providing insurance cover to 1.74 Crore policy holders",
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
                    Text("we give upo 60% insurance in every category.",
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
              onPressed: () => launch("tel:18000 425 333 33"),
              child: new Text("18000 425 333 33",style: TextStyle(fontSize:25.0,fontWeight: FontWeight.bold),)),
             
                  ],
                ),
                flex: 6,
              ),

              
              Padding(padding: EdgeInsets.only(right:130.0)),
              
            ],
          ),




          Padding(padding: EdgeInsets.only(top:40.0,left:20.0,right:20.0,bottom: 40.0)),
          Row(
            children: <Widget>[
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
  const url = "https://uiic.co.in"; 
  if (await canLaunch(url)) { 
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}

