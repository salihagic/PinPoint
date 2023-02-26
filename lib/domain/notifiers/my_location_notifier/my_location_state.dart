// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geolocator/geolocator.dart';

class MyLocationState {
  final Position? myLocation;
  final LocationPermission? permission;

  const MyLocationState({
    this.myLocation,
    this.permission,
  });

  factory MyLocationState.initial() => const MyLocationState();

  MyLocationState copyWith({
    Position? myLocation,
    LocationPermission? permission,
  }) {
    return MyLocationState(
      myLocation: myLocation ?? this.myLocation,
      permission: permission ?? this.permission,
    );
  }
}
