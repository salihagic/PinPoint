import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/data/initializers/local_data_source_initializer.dart';
import 'package:pinpoint/presentation/dismiss_focus_overlay.dart';
import 'package:pinpoint/presentation/location_permission_wrapper.dart';
import 'package:pinpoint/presentation/locations_widget.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: globalNavigatorKey,
      title: 'PinPoint',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      builder: (context, child) => FutureBuilder(
          future: ref.read(localDataSourceInitializer.future),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DismissFocusOverlay(
                child: LocationPermissionWrapper(
                  child: child,
                ),
              );
            }

            return const SizedBox();
          }),
      home: const LocationsWidget(),
    );
  }
}
