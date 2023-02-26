import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state_notifier.dart';

class MyPositionInfoWidget extends ConsumerWidget {
  const MyPositionInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myLocation = ref.watch(myLocationStateNotifierProvider).myLocation;

    if (myLocation != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text('Latitude', style: TextStyle(fontSize: 12)),
              Text('${myLocation.latitude} '),
            ],
          ),
          Column(
            children: [
              const Text('Longitude', style: TextStyle(fontSize: 12)),
              Text('${myLocation.longitude} '),
            ],
          ),
        ],
      );
    }

    return const SizedBox();
  }
}
