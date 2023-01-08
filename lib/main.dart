import 'package:flutter/material.dart';
import 'package:hiradvantista/screens/Home.dart';
import 'package:hiradvantista/screens/about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const navigationItems = [
    {
      'title': 'Fihirana advantista',
      'label': 'Accueil',
      'icon': Icons.home,
      'screen': Home(),
    },
    {
      'title': 'A propos',
      'label': 'A propos',
      'icon': Icons.info,
      'screen': About(),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fihirana advantista",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("${navigationItems[_selectedIndex]['title']}"),
        ),
        body: navigationItems[_selectedIndex]['screen'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            ...navigationItems.map((item) => BottomNavigationBarItem(
                  icon: Icon(item['icon'] as IconData),
                  label: item['label'] as String,
                  tooltip: item['title'] as String,
                ))
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
