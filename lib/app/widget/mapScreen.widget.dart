import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Import the LatLng class from the package

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        maxZoom: 18,
        interactiveFlags: InteractiveFlag.all,
        center: LatLng(-6.1035, 106.8812),
        zoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.tech_mancing.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(-6.1035, 106.8812),
              width: 30,
              height: 30,
              builder: (context) => Image.asset("assets/my-loc.png"),
            ),
          ],
        ),
      ],
    );
  }
}
