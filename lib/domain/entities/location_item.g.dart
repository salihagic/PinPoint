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
      note: fields[2] as String?,
      innerRadius: fields[3] as double,
      outerRadius: fields[4] as double,
      points: (fields[5] as List).cast<LocationPoint>(),
      type: fields[6] as LocationItemType,
    );
  }

  @override
  void write(BinaryWriter writer, LocationItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.innerRadius)
      ..writeByte(4)
      ..write(obj.outerRadius)
      ..writeByte(5)
      ..write(obj.points)
      ..writeByte(6)
      ..write(obj.type);
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
