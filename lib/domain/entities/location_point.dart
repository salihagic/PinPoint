// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pinpoint/constants/hive_types.dart';

part 'location_point.g.dart';

@HiveType(typeId: HiveTypes.location_point)
class LocationPoint extends HiveObject with EquatableMixin {
  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  LocationPoint({
    required this.latitude,
    required this.longitude,
  });

  factory LocationPoint.fromPosition(Position position) => LocationPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      );

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
