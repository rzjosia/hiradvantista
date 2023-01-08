import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/song/presentation/widgets/song_list_item.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../common_widgets/app_circular_progress_bar.dart';
import '../../application/song_service.dart';
import '../../domain/song_model.dart';

enum SongListFilterType { all, favorite }

class SongListFilter extends StatelessWidget {
  final SongListFilterType filterType;
  final String searchQuery;

  const SongListFilter(
      {Key? key,
      this.filterType = SongListFilterType.all,
      this.searchQuery = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<SongModel>("songs").listenable(),
        builder: (context, Box<SongModel> box, _) {
          SongService songService = SongService(box: box);
          late Future<List<SongModel>> songs;

          switch (filterType) {
            case SongListFilterType.favorite:
              songs = songService.getFavorites();
              break;
            default:
              songs = songService.searchSongs(searchQuery);
          }

          return FutureBuilder(
              future: songs,
              builder: (context, AsyncSnapshot<List<SongModel>> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<SongModel>;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return SongListItem(
                          key: Key("fihirana-${data[index]['id']}"),
                          song: data[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return const AppCircularProgressBar();
              });
        });
  }
}
