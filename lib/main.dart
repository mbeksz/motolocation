import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:motolocation/screens/home.dart';
import 'package:motolocation/screens/map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moto Location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Ekranlar
  final List<Widget> _screens = [
    const HomeScreen(), // Ana sayfa
    const Map(), // Harita sayfası
    Center(child: Text('Bildirimler')), // Bildirimler
    Center(child: Text('Profil')), // Profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Seçilen sayfayı göster
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.home_rounded,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: Icons.map_rounded,
            outlinedIcon: Icons.map_outlined,
          ),
          BarItem(
            filledIcon: Icons.notifications_rounded,
            outlinedIcon: Icons.notifications_outlined,
          ),
          BarItem(
            filledIcon: Icons.person_rounded,
            outlinedIcon: Icons.person_outlined,
          ),
        ],
      ),
    );
  }
}
