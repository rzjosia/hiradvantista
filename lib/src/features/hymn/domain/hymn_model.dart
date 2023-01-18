import 'package:hive_flutter/hive_flutter.dart';

part 'hymn_model.g.dart';

@HiveType(typeId: 0)
class HymnModel {
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

  @HiveField(5)
  final String? theme;

  HymnModel(
      {required this.id,
      required this.title,
      required this.key,
      required this.content,
      this.isFavorite = false,
      this.theme});

  factory HymnModel.fromJson(Map<String, dynamic> json) {
    return HymnModel(
      id: json['id'],
      title: json['title'],
      key: json['key'],
      content: json['content'],
      isFavorite: json['isFavorite'],
      theme: json['theme'] ?? "",
    );
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
      case 'theme':
        return theme;
      default:
        return null;
    }
  }
}

extension HymnModelExtension on HymnModel {
  HymnModel setIsFavorite(bool isFavorite) {
    return HymnModel(
      id: id,
      title: title,
      key: key,
      content: content,
      isFavorite: isFavorite,
      theme: theme,
    );
  }
}
