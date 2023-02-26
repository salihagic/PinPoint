import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/data/repositories/locations_repository.dart';
import 'package:pinpoint/domain/entities/location_item.dart';
import 'package:pinpoint/domain/entities/location_point.dart';
import 'package:pinpoint/domain/notifiers/location_add_notifier/location_add_state.dart';

final locationAddStateNotifierProvider =
    StateNotifierProvider<LocationAddStateNotifier, LocationAddState>(
  (ref) => LocationAddStateNotifier(
    locationsRepository: ref.read(locationsRepositoryProvider),
  ),
);

class LocationAddStateNotifier extends StateNotifier<LocationAddState> {
  final LocationsRepository locationsRepository;

  LocationAddStateNotifier({
    required this.locationsRepository,
  }) : super(LocationAddState.initial());

  Future<void> update(LocationItem item) async {
    state = state.copyWith(item: item);
  }

  Future<void> save(LocationPoint locationPoint) async {
    state = state.copyWith(status: LocationAddStateStatus.submitting);

    state.item.points.add(locationPoint);

    await locationsRepository.add(state.item);

    state = state.copyWith(status: LocationAddStateStatus.submittingSuccess);
    state = LocationAddState.initial();
  }
}
