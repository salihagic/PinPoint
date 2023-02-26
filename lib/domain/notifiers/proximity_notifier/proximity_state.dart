import 'package:pinpoint/common/optional.dart';
import 'package:pinpoint/domain/entities/location_item.dart';

enum ProximityStatus {
  unknown,
  enter,
  dwell,
  exit,
}

class ProximityInfo {
  final ProximityStatus status;
  final LocationItem locationItem;

  const ProximityInfo({
    required this.status,
    required this.locationItem,
  });

  ProximityInfo copyWith({
    ProximityStatus? status,
    LocationItem? locationItem,
  }) {
    return ProximityInfo(
      status: status ?? this.status,
      locationItem: locationItem ?? this.locationItem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.name,
      'locationItem': locationItem.toMap(),
    };
  }
}

class PoximityState {
  final ProximityInfo? proximityInfo;
  final List<ProximityInfo> proximityHistory;

  const PoximityState({
    this.proximityInfo,
    required this.proximityHistory,
  });

  factory PoximityState.initial() => const PoximityState(
        proximityHistory: [],
      );

  PoximityState copyWith({
    Optional<ProximityInfo>? proximityInfo,
    List<ProximityInfo>? proximityHistory,
  }) {
    return PoximityState(
      proximityInfo:
          proximityInfo != null ? proximityInfo.value : this.proximityInfo,
      proximityHistory: proximityHistory ?? this.proximityHistory,
    );
  }
}
