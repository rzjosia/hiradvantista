import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/features/hymn/presentation/widget/hymn_list_item_widget.dart';

import '../../../../common_widgets/app_circular_progress_bar.dart';
import '../../application/song_service.dart';
import '../../domain/song_model.dart';

class HymnFilterWidget extends ConsumerWidget {
  final HymnFilterType filterType;
  final String searchQuery;

  const HymnFilterWidget(
      {Key? key, this.filterType = HymnFilterType.all, this.searchQuery = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HymnService service = ref.watch(hymnServiceProvider);
    Future<List<SongModel>> songs =
        service.getSongsByFilter(filterType, searchQuery: searchQuery);

    return FutureBuilder(
      future: songs,
      builder: (context, AsyncSnapshot<List<SongModel>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as List<SongModel>;

          if (data.isEmpty) {
            return const Center(
              child:
                  Text("Tsy misy na inona na inona amin'izay tadiavinao ato"),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return HymnListItemWidget(
                  key: Key("fihirana-${data[index]['id']}"), song: data[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const AppCircularProgressBar();
      },
    );
  }
}
