import 'package:pinpoint/domain/entities/location_point.dart';

class LocationItemAddModel {
  final String? name;
  final double? innerRadius;
  final double? outerRadius;
  final List<LocationPoint> points;

  LocationItemAddModel({
    String? id,
    this.name,
    this.innerRadius,
    this.outerRadius,
    required this.points,
  });

  LocationItemAddModel copyWith({
    String? name,
    double? innerRadius,
    double? outerRadius,
    List<LocationPoint>? points,
  }) {
    return LocationItemAddModel(
      name: name ?? this.name,
      innerRadius: innerRadius ?? this.innerRadius,
      outerRadius: outerRadius ?? this.outerRadius,
      points: points ?? this.points,
    );
  }
}
