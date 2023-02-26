import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/domain/entities/location_point.dart';
import 'package:pinpoint/domain/models/report_model.dart';
import 'package:pinpoint/domain/notifiers/locations_notifier/locations_state_notifier.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state_notifier.dart';
import 'package:pinpoint/domain/notifiers/proximity_notifier/proximity_notifier_state_notifier.dart';

final reportProvider = Provider.autoDispose<String>(
  (ref) {
    final locations = ref.watch(locationsStateNotifierProvider).items;
    final myLocation = ref.watch(myLocationStateNotifierProvider).myLocation;
    final proximityState = ref.watch(proximityStateNotifierProvider);
    final proximityInfo = proximityState.proximityInfo;
    final proximityHistory = proximityState.proximityHistory;

    final reportModel = ReportModel(
      dateTime: DateTime.now(),
      currentLocation:
          myLocation != null ? LocationPoint.fromPosition(myLocation) : null,
      locations: locations,
      currentProximityInfo: proximityInfo,
      proximityHistory: proximityHistory,
    );

    return reportModel.toJson();
  },
);
