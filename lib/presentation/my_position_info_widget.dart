import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state_notifier.dart';
import 'package:pinpoint/presentation/position_info_widget.dart';

class MyPositionInfoWidget extends ConsumerWidget {
  const MyPositionInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myLocation = ref.watch(myLocationStateNotifierProvider).myLocation;

    if (myLocation != null) {
      return PositionInfoWidget(
        latitude: myLocation.latitude.toString(),
        longitude: myLocation.longitude.toString(),
      );
    }

    return const SizedBox();
  }
}
