import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class map_launch extends StatefulWidget {
 
  map_launch({Key key}) : super(key: key);

  @override
  _map_launchState createState() => _map_launchState();
}

class _map_launchState extends State<map_launch> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Map Launcher Demo'),
        ),
        body: Center(child: Builder(
          builder: (context) {
            return MaterialButton(
              onPressed: () => openMapsSheet(context),
              child: Text('Show Maps'),
            );
          },
        )),
      ),
    );
  }


  openMapsSheet(context) async {
    try {
      final title = "Garage";
      final description = "Service Center";
      final coords = Coords(21.1702, 72.8311);
      final availableMaps = await MapLauncher.installedMaps;

      print(availableMaps);

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                          description: description,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
  