import 'package:flutter/material.dart';
import 'package:katot_elektronik/screens/homepage.dart';
import 'package:katot_elektronik/screens/jobpart/job_tracking.dart';
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (value) {
          _onItemTapped(value);
        },
      ),
    );
  }
}
