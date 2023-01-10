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

class _HomeState extends State<Home> {
  final _pageViewController = PageController();

  int _selectedIndex = 0;

  static const navigationItems = [
    {
      'title': 'Fihirana advantista',
      'label': 'Hira',

      'icon': Icons.list,
    },
    {
      'title': 'Hitady',
      'label': 'Hitady',
      'icon': Icons.search,
    },
    {
      'title': 'Hira tianao',
      'label': 'Hira tianao',
      'icon': Icons.favorite,
    },
    {
      'title': 'Mombamomba',
      'label': 'Mombamomba',
      'icon': Icons.info,
    },
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
        title: Text("${navigationItems[_selectedIndex]['title']}"),
      ),
      body: PageView(
        controller: _pageViewController,
        onPageChanged: _onPageChanged,
        children: const [
          SongList(),
          SongList(),
          SongListFavorites(),
          About(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          ...navigationItems.map((item) => BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(item['icon'] as IconData),
                label: item['label'] as String,
                tooltip: item['title'] as String,
              ))
        ],
        elevation: 16.0,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,

        onTap: _onBottomItemTapped,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
