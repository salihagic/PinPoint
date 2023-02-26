import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinpoint/constants/storage_keys.dart';
import 'package:pinpoint/data/storage.dart';
import 'package:pinpoint/domain/entities/location_item.dart';

final locationsRepositoryProvider = Provider<LocationsRepository>(
  (ref) => LocationsRepositoryImpl(),
);

abstract class LocationsRepository {
  Future<void> init();
  Future<void> add(LocationItem locationItem);
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
  Future<void> add(LocationItem locationItem) async =>
      await _locationsStorage.add(locationItem);

  @override
  Future<List<LocationItem>> getItems() async =>
      _locationsStorage.values.toList();

  @override
  Future<void> delete(String id) async {
    final item = _locationsStorage.values.firstWhere((x) => x.id == id);

    item.delete();
  }
}
