import 'package:hive_flutter/hive_flutter.dart';

part 'song_model.g.dart';

@HiveType(typeId: 0)
class SongModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String key;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final bool? isFavorite;

  SongModel(
      {required this.id,
      required this.title,
      required this.key,
      required this.content,
      this.isFavorite = false});

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
        id: json['id'],
        title: json['title'],
        key: json['key'],
        content: json['content'],
        isFavorite: json['isFavorite']);
  }

  operator [](String currentKey) {
    switch (currentKey) {
      case 'id':
        return id;
      case 'title':
        return title;
      case 'key':
        return key;
      case 'content':
        return content;
      case 'isFavorite':
        return isFavorite;
      default:
        return null;
    }
  }

}
