// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:pinpoint/constants/hive_types.dart';
import 'package:pinpoint/domain/entities/location_point.dart';
import 'package:pinpoint/domain/enumerations/location_item_type.dart';

part 'location_item.g.dart';

@HiveType(typeId: HiveTypes.location)
class LocationItem extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? note;

  @HiveField(3)
  final double innerRadius;

  @HiveField(4)
  final double outerRadius;

  @HiveField(5)
  final List<LocationPoint> points;

  LocationPoint get point => points.first;

  @HiveField(6)
  final LocationItemType type;

  LocationItem({
    String? id,
    this.name,
    this.note,
    this.innerRadius = 0,
    this.outerRadius = 0,
    required this.points,
    this.type = LocationItemType.radius,
  }) : id = id ?? const Uuid().v1();

  @override
  List<Object?> get props => [id];

  LocationItem copyWith({
    String? id,
    String? name,
    String? note,
    double? innerRadius,
    double? outerRadius,
    List<LocationPoint>? points,
    LocationItemType? type,
  }) {
    return LocationItem(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      innerRadius: innerRadius ?? this.innerRadius,
      outerRadius: outerRadius ?? this.outerRadius,
      points: points ?? this.points,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'note': note,
      'innerRadius': innerRadius,
      'outerRadius': outerRadius,
      'points': points.map((x) => x.toMap()).toList(),
      'type': type.name,
    };
  }
}
