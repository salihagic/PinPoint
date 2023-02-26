import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<Box<T>> openStorageBox<T>(String key) async {
  await Hive.initFlutter();

  try {
    return await Hive.openBox<T>(key);
  } catch (e) {
    Hive.deleteBoxFromDisk(key);

    try {
      return await Hive.openBox<T>(key);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  return Hive.openBox<T>(key);
}
