// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savedPost.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedPostAdapter extends TypeAdapter<SavedPost> {
  @override
  final int typeId = 0;

  @override
  SavedPost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedPost(
      id: fields[0] as String,
      title: fields[1] as String,
      summary: fields[2] as String,
      link: fields[3] as String,
      postType: fields[4] as String,
      editorName: fields[5] as String,
      publishedAt: fields[6] as String,
      updatedAt: fields[7] as String,
      imageUrl: fields[8] as String,
      categoryName: fields[9] as String,
      contentHtml: fields[10] as String,
      videoUrl: fields[11] as String,
      videoEmbedCode: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedPost obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.summary)
      ..writeByte(3)
      ..write(obj.link)
      ..writeByte(4)
      ..write(obj.postType)
      ..writeByte(5)
      ..write(obj.editorName)
      ..writeByte(6)
      ..write(obj.publishedAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.imageUrl)
      ..writeByte(9)
      ..write(obj.categoryName)
      ..writeByte(10)
      ..write(obj.contentHtml)
      ..writeByte(11)
      ..write(obj.videoUrl)
      ..writeByte(12)
      ..write(obj.videoEmbedCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
