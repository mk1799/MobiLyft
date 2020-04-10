import 'package:flutter/material.dart';
class rent_add extends StatefulWidget {
   final String email;
  rent_add({Key key, this.email}) : super(key: key);
  @override
  _rent_addState createState() => _rent_addState();
}

class _rent_addState extends State<rent_add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top:30.0)),
          Container(
            height: 60.0,
            
            child: Center(
              child:Text("Add Car Details",style:TextStyle(fontSize:30.0),),
            ),
          ),

          
          TextFormField(
            
            decoration: InputDecoration(
               labelText: 'Car Model',
              focusColor: Color.fromRGBO(100, 50, 100, 0.8),
              border: InputBorder.none,
              labelStyle: TextStyle(color: Colors.grey[900], fontSize: 20.0),
              prefixIcon: const Icon(
                Icons.directions_car,
                size: 40.0,
                color: Colors.blue,
              ),
            ),
             validator: (value) =>
                value.isEmpty ? "PickUp can't be empty" : null,
            // onChanged: (value) => _model = value,
          ),
        ],
      ),
    );
  }
}