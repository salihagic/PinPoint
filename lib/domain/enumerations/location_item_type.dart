import 'package:pinpoint/constants/hive_types.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'location_item_type.g.dart';

@HiveType(typeId: HiveTypes.location_item_type)
enum LocationItemType {
  @HiveField(0)
  radius('Radius'),

  @HiveField(1)
  poligonal('Poligonal');

  final String name;

  const LocationItemType(this.name);
}
