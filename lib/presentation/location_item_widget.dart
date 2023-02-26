import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/domain/entities/location_item.dart';
import 'package:pinpoint/domain/notifiers/location_delete_notifier/location_delete_state_notifier.dart';
import 'package:pinpoint/presentation/position_info_widget.dart';

class LocationItemWidget extends ConsumerWidget {
  final LocationItem locationItem;

  const LocationItemWidget({
    super.key,
    required this.locationItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(locationItem.name ?? ''),
              ),
              Material(
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    ref
                        .read(locationDeleteStateNotifierProvider.notifier)
                        .delete(locationItem.id);
                  },
                  child: Consumer(
                    builder: (context, ref, child) {
                      final isDeletingThisItem =
                          ref.watch(locationDeleteStateNotifierProvider).id ==
                              locationItem.id;

                      if (isDeletingThisItem) {
                        return const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        );
                      }

                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.redAccent,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          PositionInfoWidget(
            withBorder: true,
            latitude: locationItem.point.latitude.toStringAsPrecision(10),
            longitude: locationItem.point.longitude.toStringAsPrecision(10),
          ),
        ],
      ),
    );
  }
}
