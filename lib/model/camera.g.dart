// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CameraAdapter extends TypeAdapter<Camera> {
  @override
  final int typeId = 0;

  @override
  Camera read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Camera(
      title: fields[0] as String?,
      description: fields[1] as String?,
      imageUrl: fields[2] as String?,
      
    );
  }

  @override
  void write(BinaryWriter writer, Camera obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
