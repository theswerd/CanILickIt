import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  //Location.instance.getLocation()
  @override
  Widget build(BuildContext context) {
    return PlatformMap(
      
      initialCameraPosition: CameraPosition(target: LatLng(
        39.50, 98.35
      )),
    );
  }
}