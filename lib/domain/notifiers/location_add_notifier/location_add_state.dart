import 'package:pinpoint/data/models/location_item_add_model.dart';
import 'package:pinpoint/domain/entities/location_point.dart';

enum LocationAddStateStatus {
  initial,
  dirty,
  submitting,
  submittingSuccess,
}

class LocationAddState {
  final LocationAddStateStatus status;
  final LocationItemAddModel model;

  LocationPoint? get lastPoint =>
      model.points.isNotEmpty ? model.points.last : null;

  const LocationAddState({
    required this.status,
    required this.model,
  });

  factory LocationAddState.initial() => LocationAddState(
        status: LocationAddStateStatus.initial,
        model: LocationItemAddModel(
          points: [],
        ),
      );

  LocationAddState copyWith({
    LocationAddStateStatus? status,
    LocationItemAddModel? model,
  }) {
    return LocationAddState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
