import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class maps extends StatefulWidget {
  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<maps> {
  String searchAddr;
  GoogleMapController mapController;

  final LatLng _center = const LatLng(21.221901, 72.900063);

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              
             
              initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 10.0,
          ),
            ),
            Positioned(
              top: 30.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height:50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10.0),
                  color:Colors.white
                ),
                child: TextField(decoration: InputDecoration(
                  hintText:"Enter Address",
                  border:InputBorder.none,
                  contentPadding:EdgeInsets.only(left: 15.0,top:15.0),
                  suffixIcon: IconButton(icon: Icon(Icons.search),
                   onPressed: 
                     searchandNavigate,
                   
                   iconSize: 30.0,
                   )
                ),
                onChanged: (val){
                  setState(() {
                    searchAddr = val;
                  });
                },
                ),
              ),
            ),
          ],
        ),
        
        // GoogleMap(
        //   onMapCreated: _onMapCreated,
        //   initialCameraPosition: CameraPosition(
        //     target: _center,
        //     zoom: 11.0,
        //   ),
        // ),
      

    );
  }
  searchandNavigate(){
    Geolocator().placemarkFromAddress(searchAddr).then((result){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target:
        
        LatLng(result[0].position.latitude,result[0].position.longitude),zoom: 15.0),
       
          
      )
      );
    });
  }
}