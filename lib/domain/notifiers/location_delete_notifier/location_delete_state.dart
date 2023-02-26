enum LocationDeleteStateStatus {
  initial,
  deleting,
  deletingSuccess,
}

class LocationDeleteState {
  final LocationDeleteStateStatus status;
  final String? id;

  const LocationDeleteState({
    required this.status,
    this.id,
  });

  factory LocationDeleteState.initial() => const LocationDeleteState(
        status: LocationDeleteStateStatus.initial,
      );

  LocationDeleteState copyWith({
    LocationDeleteStateStatus? status,
    String? id,
  }) {
    return LocationDeleteState(
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }
}
