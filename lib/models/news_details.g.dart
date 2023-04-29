// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsDetailsAdapter extends TypeAdapter<NewsDetails> {
  @override
  final int typeId = 0;

  @override
  NewsDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsDetails(
      title: fields[0] as String?,
      description: fields[1] as String?,
      content: fields[2] as String?,
      url: fields[3] as String?,
      image: fields[4] as String?,
      publishedAt: fields[5] as String?,
      sourceName: fields[6] as String?,
      sourceUrl: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NewsDetails obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.publishedAt)
      ..writeByte(6)
      ..write(obj.sourceName)
      ..writeByte(7)
      ..write(obj.sourceUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
