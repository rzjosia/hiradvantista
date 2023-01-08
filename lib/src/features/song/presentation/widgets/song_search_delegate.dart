import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/song/application/song_service.dart';
import 'package:hiradvantista/src/features/song/domain/song_model.dart';
import 'package:hiradvantista/src/features/song/presentation/widgets/song_list_filter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class SongSearchDelegate extends SearchDelegate<String> {
  final SongService songService =
      SongService(box: Hive.box<SongModel>("songs"));

  @override
  String get searchFieldLabel => 'Hitady hira';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryTextTheme: theme.textTheme,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
      textTheme: theme.textTheme.copyWith(
        headline6: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SongListFilter(searchQuery: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SongListFilter(searchQuery: query);
  }
}
