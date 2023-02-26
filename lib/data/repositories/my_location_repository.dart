import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/domain/entities/location_point.dart';

final myLocationRepositoryProvider = Provider<MyLocationRepository>(
  (ref) => MyLocationRepositoryImpl(),
);

abstract class MyLocationRepository {
  Future<LocationPermission> init();
  Future<LocationPermission> getPermission();
  Future openSettings();
  Future<Position?> getMyLocation();
  Stream<Position> getMyLocationStream();
  Future<bool> isEnabledAndAllowed();
  bool isPointInsideTheRadius(
      LocationPoint point, LocationPoint targetPoint, double radiusInMeters);
}

class MyLocationRepositoryImpl implements MyLocationRepository {
  @override
  Future<LocationPermission> init() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      return await Geolocator.requestPermission();
    }

    return permission;
  }

  @override
  Future<LocationPermission> getPermission() async =>
      await Geolocator.checkPermission();

  @override
  Future<bool> openSettings() async =>
      await Geolocator.openAppSettings() ||
      await Geolocator.openLocationSettings();

  @override
  Future<Position?> getMyLocation() async => await isEnabledAndAllowed()
      ? await Geolocator.getCurrentPosition()
      : null;

  @override
  Stream<Position> getMyLocationStream() => Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
        ),
      );

  @override
  Future<bool> isEnabledAndAllowed() async =>
      await Geolocator.isLocationServiceEnabled() &&
      [
        LocationPermission.always,
        LocationPermission.whileInUse,
      ].contains(await Geolocator.checkPermission());

  @override
  bool isPointInsideTheRadius(
      LocationPoint point, LocationPoint targetPoint, double radiusInMeters) {
    final distance = _calculateAirDistanceInMeters(point, targetPoint);

    return distance <= radiusInMeters;
  }

  double _calculateAirDistanceInMeters(
          LocationPoint start, LocationPoint end) =>
      Geolocator.distanceBetween(
          start.latitude, start.longitude, end.latitude, end.longitude);
}
