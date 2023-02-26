import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/data/repositories/locations_repository.dart';
import 'package:pinpoint/domain/notifiers/location_delete_notifier/location_delete_state.dart';

final locationDeleteStateNotifierProvider =
    StateNotifierProvider<LocationDeleteStateNotifier, LocationDeleteState>(
  (ref) => LocationDeleteStateNotifier(
    locationsRepository: ref.read(locationsRepositoryProvider),
  ),
);

class LocationDeleteStateNotifier extends StateNotifier<LocationDeleteState> {
  final LocationsRepository locationsRepository;

  LocationDeleteStateNotifier({
    required this.locationsRepository,
  }) : super(LocationDeleteState.initial());

  Future<void> delete(String id) async {
    state = state.copyWith(status: LocationDeleteStateStatus.deleting, id: id);

    await locationsRepository.delete(id);

    state = state.copyWith(status: LocationDeleteStateStatus.deletingSuccess);
    state = LocationDeleteState.initial();
  }
}
