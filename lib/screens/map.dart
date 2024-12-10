import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    const LatLng pGooglePlex = LatLng(41.0082, 28.9784);
    return const Scaffold(
      body: Center(
          child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: pGooglePlex, zoom: 13))),
    );
  }
}
