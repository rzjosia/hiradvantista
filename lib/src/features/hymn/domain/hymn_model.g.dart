// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HymnModelAdapter extends TypeAdapter<HymnModel> {
  @override
  final int typeId = 0;

  @override
  HymnModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HymnModel(
      id: fields[0] as int,
      title: fields[1] as String,
      key: fields[2] as String,
      content: fields[3] as String,
      isFavorite: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HymnModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.key)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HymnModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
