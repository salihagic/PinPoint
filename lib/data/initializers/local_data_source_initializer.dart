import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:pinpoint/data/initializers/initializer.dart';
import 'package:pinpoint/data/repositories/locations_repository.dart';
import 'package:pinpoint/domain/entities/location_item.dart';
import 'package:pinpoint/domain/entities/location_point.dart';
import 'package:pinpoint/domain/enumerations/location_item_type.dart';

void registerHiveAdapters() {
  Hive.registerAdapter(LocationPointAdapter());
  Hive.registerAdapter(LocationItemAdapter());
  Hive.registerAdapter(LocationItemTypeAdapter());
}

final localDataSourceInitializer = FutureProvider(
  (ref) async => await LocalDataSourceInitializer(ref).init(),
);

class LocalDataSourceInitializer extends Initializer {
  LocalDataSourceInitializer(super.ref);

  @override
  Future<void> init() async {
    await ref.read(locationsRepositoryProvider).init();
  }
}
