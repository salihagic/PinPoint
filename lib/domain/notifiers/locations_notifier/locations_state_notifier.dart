import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/data/repositories/locations_repository.dart';
import 'package:pinpoint/domain/notifiers/location_add_notifier/location_add_state.dart';
import 'package:pinpoint/domain/notifiers/location_add_notifier/location_add_state_notifier.dart';
import 'package:pinpoint/domain/notifiers/location_delete_notifier/location_delete_state.dart';
import 'package:pinpoint/domain/notifiers/location_delete_notifier/location_delete_state_notifier.dart';
import 'package:pinpoint/domain/notifiers/locations_notifier/locations_state.dart';

final locationsStateNotifierProvider =
    StateNotifierProvider<LocationsStateNotifier, LocationsState>(
  (ref) => LocationsStateNotifier(
    ref: ref,
    locationsRepository: ref.read(locationsRepositoryProvider),
  ),
);

class LocationsStateNotifier extends StateNotifier<LocationsState> {
  final Ref ref;
  final LocationsRepository locationsRepository;

  LocationsStateNotifier({
    required this.ref,
    required this.locationsRepository,
  }) : super(LocationsState.initial()) {
    load();

    ref.listen(
      locationAddStateNotifierProvider,
      (previous, next) {
        if (next.status == LocationAddStateStatus.submittingSuccess) {
          load();
        }
      },
    );

    ref.listen(
      locationDeleteStateNotifierProvider,
      (previous, next) {
        if (next.status == LocationDeleteStateStatus.deletingSuccess) {
          load();
        }
      },
    );
  }

  Future<void> load() async {
    final items = await locationsRepository.getItems();

    state = state.copyWith(items: items);
  }
}
