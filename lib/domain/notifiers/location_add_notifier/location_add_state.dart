import 'package:pinpoint/domain/entities/location_item.dart';

enum LocationAddStateStatus {
  initial,
  dirty,
  submitting,
  submittingSuccess,
}

class LocationAddState {
  final LocationAddStateStatus status;
  final LocationItem item;

  const LocationAddState({
    required this.status,
    required this.item,
  });

  factory LocationAddState.initial() => LocationAddState(
        status: LocationAddStateStatus.initial,
        item: LocationItem(
          points: [],
        ),
      );

  LocationAddState copyWith({
    LocationAddStateStatus? status,
    LocationItem? item,
  }) {
    return LocationAddState(
      status: status ?? this.status,
      item: item ?? this.item,
    );
  }
}
