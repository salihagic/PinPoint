// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pinpoint/domain/entities/location_item.dart';
import 'package:pinpoint/domain/entities/location_point.dart';
import 'package:pinpoint/domain/notifiers/proximity_notifier/proximity_state.dart';

class ReportModel {
  final DateTime dateTime;
  final LocationPoint? currentLocation;
  final List<LocationItem> locations;
  final ProximityInfo? currentProximityInfo;
  final List<ProximityInfo> proximityHistory;

  ReportModel({
    required this.dateTime,
    required this.currentLocation,
    required this.locations,
    required this.currentProximityInfo,
    required this.proximityHistory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'currentLocation': currentLocation?.toMap(),
      'locations': locations.map((x) => x.toMap()).toList(),
      'currentProximityInfo': currentProximityInfo?.toMap(),
      'proximityHistory': proximityHistory.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
