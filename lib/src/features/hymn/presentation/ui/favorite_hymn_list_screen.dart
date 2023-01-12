import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/hymn/presentation/widget/hymn_filter_widget.dart';

import '../../application/song_service.dart';

class FavoriteHymnListScreen extends StatelessWidget {
  const FavoriteHymnListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hira tianao'),
        backgroundColor: Colors.red,
      ),
      body: const HymnFilterWidget(filterType: HymnFilterType.favorite),
    );
  }
}