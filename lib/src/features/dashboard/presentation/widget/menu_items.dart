import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/about/presentation/ui/about_screen.dart';
import 'package:hiradvantista/src/features/hymn/presentation/ui/favorite_hymn_list_screen.dart';
import 'package:hiradvantista/src/features/hymn/presentation/ui/hymn_list_screen.dart';
import 'package:hiradvantista/src/features/setting/presentation/ui/setting_screen.dart';

class MenuItem {
  final String name;
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Widget screen;

  const MenuItem({
    required this.name,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.screen,
  });
}

class Menu {
  static const String home = 'Home';
  static const String favorite = 'favorite';
  static const String setting = 'settings';
  static const String about = 'about';

  static const List<MenuItem> items = <MenuItem>[
    MenuItem(
        name: home,
        title: "Hira",
        icon: Icons.list,
        backgroundColor: Colors.blue,
        screen: HymnListScreen()),
    MenuItem(
        name: favorite,
        title: "Hira tianao",
        icon: Icons.favorite,
        backgroundColor: Colors.red,
        screen: FavoriteHymnListScreen()),
    MenuItem(
        name: setting,
        title: "Settings",
        icon: Icons.settings,
        backgroundColor: Colors.blueGrey,
        screen: SettingScreen()),
    MenuItem(
        name: about,
        title: "Mombamomba",
        icon: Icons.info,
        backgroundColor: Colors.teal,
        screen: AboutScreen()),
  ];

  static MenuItem getMenuItem(String name) {
    return items.firstWhere((element) => element.name == name);
  }
}
