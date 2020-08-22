import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobilyft/Crud_File/crud1.dart';

class MapDest extends StatefulWidget {
   @override
   State<StatefulWidget> createState() => MapDestState();
   String _locationMessage;
   String savecoord(){
     return _locationMessage;
   }
}
class MapDestState extends State<MapDest> {
  CRUD1 crudobj = new CRUD1();
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
      super.initState();
      setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'asets/destination_map_marker.png');
  }

String _locationMessage = ""; 

  void coord(position) async {
    print(position);
    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
      
    });
    print(_locationMessage);

  }

 String savecoord(){
   return _locationMessage;
   
  }
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(21.225992,72.8236681);
    
    // these are the minimum required values to set 
    // the camera position 
    CameraPosition initialLocation = CameraPosition(
        zoom: 20,
        bearing: 30,
         tilt: 59.440717697143555,
        target: pinPosition
    );

    return Scaffold(
          body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            markers: _markers,
            
            initialCameraPosition: initialLocation,
            onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(Utils.mapStyles);
                _controller.complete(controller);
                setState(() {
                  _markers.add(
                      Marker(
                        draggable: true,
                        markerId: MarkerId('<MARKER_ID>'),
                        position: pinPosition,
                        icon: pinLocationIcon,
                        onDragEnd: ((_position) => coord(_position)),
                      )
                      
                  );
              });
            }
            ),
            FloatingActionButton(onPressed: (){ Navigator.pop(context, true);})
        ],
      ),
    );
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
