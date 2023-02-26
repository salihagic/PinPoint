import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/data/initializers/local_data_source_initializer.dart';
import 'package:pinpoint/presentation/app.dart';

Future<void> main() async {
  registerHiveAdapters();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
