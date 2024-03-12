import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;




class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/rebhyyy/cl062b7qg001r14n18xsk07h4/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmViaHl5eSIsImEiOiJjbDA2MjJyeHcwY20xM2RubmxqZnBlOGZmIn0.cwOIGoOD4WmUvkjL3C2dvg",
            additionalOptions: {
              'accessToken' : 'pk.eyJ1IjoicmViaHl5eSIsImEiOiJjbDA2MjJyeHcwY20xM2RubmxqZnBlOGZmIn0.cwOIGoOD4WmUvkjL3C2dvg',
              'id' : 'mapbox.mapbox-streets-v8'
            },
            attributionBuilder: (_) {
              return Text("© OpenStreetMap contributors");
            },
          ),
         /* MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point:new LatLng(51.5, -0.09),
                builder: (ctx) =>
                    Container(
                      child: FlutterLogo(),
                    ),
              ),
            ],
          ),
    */
        ],
      ),
    );
  }
}
