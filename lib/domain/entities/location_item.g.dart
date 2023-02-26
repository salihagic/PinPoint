// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationItemAdapter extends TypeAdapter<LocationItem> {
  @override
  final int typeId = 0;

  @override
  LocationItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationItem(
      id: fields[0] as String?,
      name: fields[1] as String?,
      innerRadius: fields[2] as double,
      outerRadius: fields[3] as double,
      point: fields[4] as LocationPoint,
    );
  }

  @override
  void write(BinaryWriter writer, LocationItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.innerRadius)
      ..writeByte(3)
      ..write(obj.outerRadius)
      ..writeByte(4)
      ..write(obj.point);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
