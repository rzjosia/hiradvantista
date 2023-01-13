import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/song_service.dart';
import '../../domain/song_model.dart';

class HymnListItemWidget extends ConsumerWidget {
  final SongModel song;

  const HymnListItemWidget({required this.song, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HymnService hymnService = ref.watch(hymnServiceProvider);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
        child: Text("${song.id}", style: const TextStyle(fontSize: 15)),
      ),
      title: Text(song.title),
      trailing: IconButton(
        key: Key("favorite-${song.id}"),
        icon: song.isFavorite == true
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : const Icon(Icons.favorite_border),
        onPressed: () async {
          await hymnService.toggleFavorite(song);
        },
      ),
      onTap: () {
        GoRouter.of(context).push("/hymn/${song.id}");
      },
    );
  }
}
