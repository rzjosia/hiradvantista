import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/core/presentation/about.dart';
import 'package:hiradvantista/src/features/song/presentation/song_list.dart';
import 'package:hiradvantista/src/features/song/presentation/widgets/song_list_favorites.dart';
import 'package:hiradvantista/src/features/song/presentation/widgets/song_search_delegate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class MenuItem {
  final String title;
  final IconData icon;
  final Widget widget;
  final Color backgroundColor;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.widget,
    required this.backgroundColor,
  });
}

class _HomeState extends State<Home> {
  final _pageViewController = PageController();

  int _selectedIndex = 0;

  static const navigationItems = [
    MenuItem(
      title: "Fihirana",
      icon: Icons.music_note,
      widget: SongList(),
      backgroundColor: Colors.blue,
    ),
    MenuItem(
      title: "Hitady",
      icon: Icons.search,
      widget: SongList(),
      backgroundColor: Colors.green,
    ),
    MenuItem(
      title: "Favorites",
      icon: Icons.favorite,
      widget: SongListFavorites(),
      backgroundColor: Colors.red,
    ),
    MenuItem(
      title: "Mombamomba",
      icon: Icons.info,
      widget: About(),
      backgroundColor: Colors.green,
    ),
  ];

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      showSearch(
          context: context,
          delegate: SongSearchDelegate(),
          useRootNavigator: true);
    }
  }

  void _onBottomItemTapped(int index) {
    _pageViewController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(navigationItems[_selectedIndex].title),
        backgroundColor: navigationItems[_selectedIndex].backgroundColor,
      ),
      body: PageView(
        controller: _pageViewController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          ...navigationItems.map((item) => item.widget),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        clipBehavior: Clip.hardEdge,
        //or better look(and cost) using Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: <BottomNavigationBarItem>[
            ...navigationItems.map((item) => BottomNavigationBarItem(
                  backgroundColor: item.backgroundColor,
                  icon: Icon(item.icon),
                  label: item.title,
                  tooltip: item.title,
                ))
          ],
          elevation: 16.0,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          onTap: _onBottomItemTapped,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
