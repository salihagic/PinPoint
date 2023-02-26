import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/data/models/location_item_add_model.dart';
import 'package:pinpoint/data/repositories/locations_repository.dart';
import 'package:pinpoint/domain/entities/location_point.dart';
import 'package:pinpoint/domain/notifiers/location_add_notifier/location_add_state.dart';

final locationAddStateNotifierProvider =
    StateNotifierProvider<LocationAddStateNotifier, LocationAddState>(
  (ref) => LocationAddStateNotifier(
    ref: ref,
    locationsRepository: ref.read(locationsRepositoryProvider),
  ),
);

class LocationAddStateNotifier extends StateNotifier<LocationAddState> {
  final Ref ref;
  final LocationsRepository locationsRepository;

  LocationAddStateNotifier({
    required this.ref,
    required this.locationsRepository,
  }) : super(LocationAddState.initial());

  Future<void> update(LocationItemAddModel model) async {
    state = state.copyWith(status: LocationAddStateStatus.dirty, model: model);
  }

  Future<void> addPoint(LocationPoint point) async {
    final currentPoints = List<LocationPoint>.from(state.model.points);

    currentPoints.add(point);

    state = state.copyWith(
      status: LocationAddStateStatus.dirty,
      model: state.model.copyWith(points: currentPoints),
    );
  }

  Future<void> save() async {
    state = state.copyWith(status: LocationAddStateStatus.submitting);

    await locationsRepository.add(state.model);

    state = state.copyWith(status: LocationAddStateStatus.submittingSuccess);
    state = LocationAddState.initial();
  }
}
