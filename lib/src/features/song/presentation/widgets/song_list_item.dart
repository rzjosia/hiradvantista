import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/song/application/song_service.dart';
import 'package:hiradvantista/src/features/song/domain/song_model.dart';
import 'package:hiradvantista/src/features/song/presentation/song.dart';
import 'package:hive/hive.dart';

class SongListItem extends StatelessWidget {
  final SongModel song;

  const SongListItem({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
        child: Text("${song.id}", style: const TextStyle(fontSize: 15)),
      ),
      title: Text(song.title),
      trailing: IconButton(
        icon: song.isFavorite == true
            ? const Icon(Icons.favorite, color: Colors.red)
            : const Icon(Icons.favorite_border),
        onPressed: () async {
          SongService songService =
              SongService(box: Hive.box<SongModel>("songs"));

          await songService.toggleFavorite(song);
        },
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Song(id: song.id)));
      },
    );
  }
}
