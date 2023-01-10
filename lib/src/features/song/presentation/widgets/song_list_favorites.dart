import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/song/presentation/widgets/song_list_filter.dart';

class SongListFavorites extends StatelessWidget {
  const SongListFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SongListFilter(filterType: SongListFilterType.favorite);
  }
}
