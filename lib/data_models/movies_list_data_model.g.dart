// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_list_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieListResultAdapter extends TypeAdapter<MovieListResult> {
  @override
  final int typeId = 0;

  @override
  MovieListResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieListResult(
      id: fields[0] as int,
      originalTitle: fields[1] as String,
      posterPath: fields[2] as String,
      mediaType: fields[3] as String,
      originalLanguage: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieListResult obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.originalTitle)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.mediaType)
      ..writeByte(4)
      ..write(obj.originalLanguage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieListResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
