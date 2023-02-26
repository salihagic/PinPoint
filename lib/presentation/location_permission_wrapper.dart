import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state_notifier.dart';
import 'package:pinpoint/presentation/app.dart';
import 'package:pinpoint/presentation/location_access_settings_dialog.dart';

class LocationPermissionWrapper extends ConsumerStatefulWidget {
  const LocationPermissionWrapper({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  ConsumerState<LocationPermissionWrapper> createState() =>
      _LocationPermissionWrapperState();
}

class _LocationPermissionWrapperState
    extends ConsumerState<LocationPermissionWrapper>
    with WidgetsBindingObserver {
  AppLifecycleState lastAppState = AppLifecycleState.resumed;

  @override
  void initState() {
    super.initState();

    ref.read(myLocationStateNotifierProvider.notifier).init();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    final wasDeniedForever =
        ref.read(myLocationStateNotifierProvider).permission ==
            LocationPermission.deniedForever;

    final wasUserInSettings = appLifecycleState == AppLifecycleState.resumed &&
        lastAppState == AppLifecycleState.paused;

    // To re-check location permission once the user returns from settings
    if (wasUserInSettings && wasDeniedForever) {
      ref.read(myLocationStateNotifierProvider.notifier).init();
    }

    lastAppState = appLifecycleState;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<MyLocationState>(
      myLocationStateNotifierProvider,
      (previousState, state) {
        debugPrint(
            ':::LOCATION::: LATITUDE:${state.myLocation?.latitude} | LONGITUDE:${state.myLocation?.longitude}');

        if (state.permission == LocationPermission.deniedForever) {
          showDialog(
            context: globalNavigatorKey.currentState!.context,
            builder: (context) => const LocationAccessSettingsDialog(),
          );
        }
      },
    );

    return widget.child!;
  }
}
