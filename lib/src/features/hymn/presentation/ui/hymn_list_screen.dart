import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/hymn/presentation/widget/hymn_filter_widget.dart';

import '../widget/hymn_search_delegate_widget.dart';

class HymnListScreen extends StatelessWidget {
  const HymnListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.white,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                  left: 76, right: 45, bottom: 16, top: 52),
              title: const Text('Hira',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              background: Image.asset(
                "assets/images/hymn_sliver_background.jpg",
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: HymnSearchDelegateWidget(),
                  );
                },
              ),
            ],
          ),
          const HymnFilterWidget(isSliver: true),
        ],
      ),
    );
  }
}
