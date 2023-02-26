import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pinpoint/common/optional.dart';
import 'package:pinpoint/data/repositories/my_location_repository.dart';
import 'package:pinpoint/domain/entities/location_item.dart';
import 'package:pinpoint/domain/entities/location_point.dart';
import 'package:pinpoint/domain/enumerations/location_item_type.dart';
import 'package:pinpoint/domain/notifiers/locations_notifier/locations_state_notifier.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state_notifier.dart';
import 'package:pinpoint/domain/notifiers/proximity_notifier/proximity_state.dart';

final proximityStateNotifierProvider =
    StateNotifierProvider<ProximityStateNotifier, PoximityState>(
  (ref) => ProximityStateNotifier(
    ref: ref,
    myLocationRepository: ref.read(myLocationRepositoryProvider),
  ),
);

class ProximityStateNotifier extends StateNotifier<PoximityState> {
  final Ref ref;
  final MyLocationRepository myLocationRepository;

  ProximityStateNotifier({
    required this.ref,
    required this.myLocationRepository,
  }) : super(PoximityState.initial()) {
    ref.listen(
      myLocationStateNotifierProvider,
      (previous, next) => determineProximity(
          next.myLocation!, ref.watch(locationsStateNotifierProvider).items),
    );
  }

  void determineProximity(
      Position myLocation, List<LocationItem> locationItems) async {
    for (final locationItem in locationItems) {
      if (locationItem.type == LocationItemType.radius) {
        _calculateRadiusLogic(myLocation, locationItem);
      }
    }
  }

  void _calculateRadiusLogic(
      Position myLocation, LocationItem locationItem) async {
    // Check for entrance or dwell
    final isPointInsideTheInnerRadius =
        myLocationRepository.isPointInsideTheRadius(
      LocationPoint.fromPosition(myLocation),
      locationItem.points.first,
      locationItem.innerRadius,
    );
    final isTheSameAsCurrent =
        locationItem == state.proximityInfo?.locationItem;

    if (isPointInsideTheInnerRadius) {
      state = state.copyWith(
        proximityInfo: Optional(
          ProximityInfo(
            status: isTheSameAsCurrent
                ? ProximityStatus.dwell
                : ProximityStatus.enter,
            locationItem: locationItem,
          ),
        ),
      );
    }

    // Check for exits
    final isPointInsideTheOuterRadius =
        myLocationRepository.isPointInsideTheRadius(
      LocationPoint.fromPosition(myLocation),
      locationItem.points.first,
      locationItem.outerRadius,
    );

    if (!isPointInsideTheOuterRadius && isTheSameAsCurrent) {
      final proximityHistory = List<ProximityInfo>.from(state.proximityHistory);

      if (state.proximityInfo != null) {
        proximityHistory.insert(0, state.proximityInfo!);
      }

      state = state.copyWith(
        proximityInfo: const Optional.absent(),
        proximityHistory: proximityHistory,
      );
    }
  }
}
