import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinpoint/constants/storage_keys.dart';
import 'package:pinpoint/data/models/location_item_add_model.dart';
import 'package:pinpoint/data/storage.dart';
import 'package:pinpoint/domain/entities/location_item.dart';
import 'package:pinpoint/domain/entities/location_point.dart';

final locationsRepositoryProvider = Provider<LocationsRepository>(
  (ref) => LocationsRepositoryImpl(),
);

abstract class LocationsRepository {
  Future<void> init();
  Future<void> add(LocationItemAddModel model);
  Future<List<LocationItem>> getItems();
  Future<void> delete(String id);
}

class LocationsRepositoryImpl implements LocationsRepository {
  late Box<LocationItem> _locationsStorage;

  @override
  Future<void> init() async {
    _locationsStorage =
        await openStorageBox<LocationItem>(StorageKeys.locations);
  }

  @override
  Future<void> add(LocationItemAddModel model) async {
    final midPoint = _calculateMidPoint(model.points);

    final item = LocationItem(
      name: model.name,
      innerRadius: model.innerRadius,
      outerRadius: model.outerRadius,
      point: midPoint,
    );

    await _locationsStorage.add(item);
  }

  @override
  Future<List<LocationItem>> getItems() async =>
      _locationsStorage.values.toList();

  @override
  Future<void> delete(String id) async {
    final item = _locationsStorage.values.firstWhere((x) => x.id == id);

    item.delete();
  }

  LocationPoint _calculateMidPoint(List<LocationPoint> points) {
    if (points.isEmpty) {
      throw ArgumentError('List of points cannot be empty');
    }

    double sumLatitude = 0;
    double sumLongitude = 0;
    int count = points.length;

    for (var point in points) {
      sumLatitude += point.latitude;
      sumLongitude += point.longitude;
    }

    double centerLatitude = sumLatitude / count;
    double centerLongitude = sumLongitude / count;

    return LocationPoint(
      latitude: centerLatitude,
      longitude: centerLongitude,
    );
  }
}
