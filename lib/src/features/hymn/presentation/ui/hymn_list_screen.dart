import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/hymn/presentation/widget/hymn_filter_widget.dart';

import '../widget/hymn_search_delegate_widget.dart';

class HymnListScreen extends StatelessWidget {
  const HymnListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hira'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: HymnSearchDelegateWidget());
            },
          ),
        ],
      ),
      body: const HymnFilterWidget(),
    );
  }
}
