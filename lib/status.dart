import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:geolocator/geolocator.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  MapView mapView = new MapView();

  void initState(){
    super.initState();
    _showMap();
  }

  @override
  Widget build(BuildContext context) {
    var provider = new StaticMapProvider('AIzaSyBQxUOjs6G-q62epjU3GNl2L7BABINCgqk');

    return Scaffold(
      appBar: AppBar(
        title: Text('Status'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text('Teste1'),
            Image.network(
              provider.getImageUriFromMap(mapView, width: 900, height: 400).toString()
            ),
            Text('TEstetste'),
          ],
        ),
      ),
    );
  }

  void _showMap() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    mapView.addMarker(
      new Marker('1', 'Example', 45.5259467, -122.687747)
    );

    mapView.show(
      new MapOptions(
        mapViewType: MapViewType.normal,
        showUserLocation: true,
        initialCameraPosition: new CameraPosition(
            new Location(45.5235258, -122.6732493), 14.0),
        title: "Recently Visited"
      ),
      toolbarActions: [new ToolbarAction("Close", 1)]
    );
  }
}