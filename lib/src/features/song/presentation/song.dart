import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/song/domain/song_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../application/song_service.dart';

class Song extends StatelessWidget {
  final int id;

  const Song({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<SongModel>("songs").listenable(),
        builder: (context, Box<SongModel> box, _) {
          SongService songService = SongService(box: box);
          final Future<SongModel> song = songService.getSongByNumerous(id);

          return FutureBuilder(
            future: song,
            builder: (context, AsyncSnapshot<SongModel> snapshot) {
              if (snapshot.hasData) {
                final song = snapshot.data as SongModel;
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Hira ${song.id}"),
                  ),
                  body: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(song.title,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontSize: 18, height: 1.5)),
                        ),
                      ),
                      if (song.key != "")
                        SizedBox(
                          width: double.infinity,
                          child: Text("Do dia ${song.key}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  fontStyle: FontStyle.italic)),
                        ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(song.content,
                              style:
                                  const TextStyle(fontSize: 18, height: 1.5)),
                        ),
                      )
                    ]),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return const CircularProgressIndicator();
            },
          );
        });
  }
}
