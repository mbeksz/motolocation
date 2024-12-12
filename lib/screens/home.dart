import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motolocation/constants/color.dart';
import 'map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigateToMap() async {
    // Map sayfasına yönlendirme
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Map()),
    );
    // Geri dönüldüğünde `home` simgesini seçili yap
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(backgroundColor),
      appBar: AppBar(
        backgroundColor: HexColor(backgroundColor),
        title: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Icon(
            Icons.list,
            color: HexColor(primaryColor),
            size: 40,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Image(
                image: AssetImage('lib/assets/images/beepbeep.png'),
                width: 400,
                height: 400),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Moto Location',
                  style: TextStyle(
                    color: HexColor(white),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Güvenliğinizi düşünür, motorunuzu koruruz!',
                    style: TextStyle(
                      color: HexColor(white),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      // Butona tıklandığında Motorum Nerde? sayfasına yönlendirme
                      _navigateToMap();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor(primaryColor), // Buton rengi
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20), // Buton genişliği ve yüksekliği
                      textStyle: const TextStyle(fontSize: 20), // Yazı boyutu
                    ),
                    child: const Text(
                      'Motorum Nerde?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
