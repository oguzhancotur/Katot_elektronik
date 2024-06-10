import 'package:flutter/material.dart';
import 'package:katot_elektronik/screens/homepage.dart';
import 'package:katot_elektronik/screens/jobpart/job_tracking.dart';
import 'package:katot_elektronik/screens/profile.dart';
import 'package:katot_elektronik/screens/stockpart/stock_tracking.dart';

class MainScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainScreen> {
  int _selectedIndex = 1;

  // Sayfaları tanımlayın
  final List<Widget> _pages = [
    JobTracking(),
    Homepage(),
    StockTracking(),
    Profile()
  ];

  // Seçilen sayfayı güncelleyen metot
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Job Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Stock Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black54,
        selectedItemColor: const Color(0xFF79A3B1),
        backgroundColor: Colors.black,
        onTap: (value) {
          _onItemTapped(value);
        },
      ),
    );
  }
}
