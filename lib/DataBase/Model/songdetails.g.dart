// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songdetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongDetailsAdapter extends TypeAdapter<SongDetails> {
  @override
  final int typeId = 0;

  @override
  SongDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongDetails(
      name: fields[1] as String?,
      artist: fields[2] as String?,
      duration: fields[3] as int?,
      id: fields[4] as int?,
      url: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SongDetails obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
