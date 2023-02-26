import 'package:pinpoint/domain/entities/location_item.dart';

class LocationsState {
  final List<LocationItem> items;

  const LocationsState({
    required this.items,
  });

  factory LocationsState.initial() => const LocationsState(items: []);

  LocationsState copyWith({
    List<LocationItem>? items,
  }) {
    return LocationsState(
      items: items ?? this.items,
    );
  }
}
