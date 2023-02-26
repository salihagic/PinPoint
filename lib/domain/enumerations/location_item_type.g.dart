// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_item_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationItemTypeAdapter extends TypeAdapter<LocationItemType> {
  @override
  final int typeId = 2;

  @override
  LocationItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LocationItemType.radius;
      case 1:
        return LocationItemType.poligonal;
      default:
        return LocationItemType.radius;
    }
  }

  @override
  void write(BinaryWriter writer, LocationItemType obj) {
    switch (obj) {
      case LocationItemType.radius:
        writer.writeByte(0);
        break;
      case LocationItemType.poligonal:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
