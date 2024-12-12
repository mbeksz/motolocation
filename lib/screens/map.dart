import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motolocation/constants/color.dart';
import 'package:geocoding/geocoding.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => MapSampleState();
}

class MapSampleState extends State<Map> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition _initialPosition = const CameraPosition(
      target: LatLng(41.10310064718541, 28.76320218114695), // Varsayılan konum
      zoom: 15);

  Set<Marker> _markers = {};
  LatLng _motorPosition = const LatLng(37.4231272, -122.0839891);
  Timer? _timer; // Timer için bir değişken tanımlandı
  String _locationName = 'İstanbul, Türkiye';

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
    _setMotocycleLocation();
    _startMotorMovement();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Timer'ı durdur
    super.dispose();
  }

  Future<void> _setInitialLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      );
    });
  }

  Future<void> _setMotocycleLocation() async {
    // ignore: deprecated_member_use
    final BitmapDescriptor motoIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(5, 5)), // İkon boyutlandırma
      'lib/assets/images/scooter.png',
    );

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('motor'),
          position: _motorPosition,
          infoWindow:
              InfoWindow(title: _locationName, snippet: 'Motorun konumu'),
          icon: motoIcon,
        ),
      );
    });
  }

  void _startMotorMovement() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _updateMotorPosition();
    });
  }

  void _updateMotorPosition() {
    final random = Random();
    const double distance = 0.002; // Yaklaşık 200 metre

    // Rastgele yeni konum hesaplama
    final double newLatitude =
        _motorPosition.latitude + (random.nextBool() ? distance : -distance);
    final double newLongitude =
        _motorPosition.longitude + (random.nextBool() ? distance : -distance);

    setState(() {
      _motorPosition = LatLng(newLatitude, newLongitude);
      _markers = {
        Marker(
          markerId: const MarkerId('motor'),
          position: _motorPosition,
          infoWindow: InfoWindow(
              title: _locationName, snippet: 'Motorun güncel konumu'),
          icon: _markers.first.icon, // Aynı ikon kullanılıyor
        ),
      };
    });
  }

  Future<void> _goToTheMoto() async {
    final CameraPosition motoCameraPosition = CameraPosition(
      target: _motorPosition, // Güncel motor konumu
      zoom: 17,
    );

    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(motoCameraPosition));
  }

  void _getDirections() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Yol tarifi alınıyor...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harita'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _initialPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _markers,
                  myLocationEnabled: true, // Cihazın konumunu göster
                  myLocationButtonEnabled: true, // Konum düğmesini etkinleştir
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: _goToTheMoto,
                      child: const Image(
                        image: AssetImage('lib/assets/images/scooter.png'),
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: HexColor(backgroundColor),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Başakşehir Millet Bahçesi",
                        style: TextStyle(
                            color: HexColor(primaryColor),
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Table(
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                "Konum güncellemesi:",
                                style: TextStyle(
                                    color: HexColor(white),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                "5 dakika önce",
                                style: TextStyle(
                                    color: HexColor(white),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                "Tahmini Uzaklık:",
                                style: TextStyle(
                                    color: HexColor(white),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                "200 m",
                                style: TextStyle(
                                    color: HexColor(white),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                "Konum güvenliği:",
                                style: TextStyle(
                                    color: HexColor(white),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: HexColor(primaryColor),
                                  ),
                                  Text(
                                    "4.5",
                                    style: TextStyle(
                                        color: HexColor(white),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                "Yol tarifi başlat",
                                style: TextStyle(
                                    color: HexColor(white),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  _getDirections();
                                },
                                child: Text(
                                  "Başlat",
                                  style: TextStyle(
                                      color: HexColor(primaryColor),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
