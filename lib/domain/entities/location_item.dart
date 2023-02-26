import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:pinpoint/constants/hive_types.dart';
import 'package:pinpoint/domain/entities/location_point.dart';

part 'location_item.g.dart';

@HiveType(typeId: HiveTypes.location)
class LocationItem extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final double innerRadius;

  @HiveField(3)
  final double outerRadius;

  @HiveField(4)
  final LocationPoint point;

  LocationItem({
    String? id,
    this.name,
    this.innerRadius = 0,
    this.outerRadius = 0,
    required this.point,
  }) : id = id ?? const Uuid().v1();

  @override
  List<Object?> get props => [id];

  LocationItem copyWith({
    String? id,
    String? name,
    double? innerRadius,
    double? outerRadius,
    LocationPoint? point,
  }) {
    return LocationItem(
      id: id ?? this.id,
      name: name ?? this.name,
      innerRadius: innerRadius ?? this.innerRadius,
      outerRadius: outerRadius ?? this.outerRadius,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'innerRadius': innerRadius,
      'outerRadius': outerRadius,
      'points': point.toMap(),
    };
  }
}
