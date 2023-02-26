import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:pinpoint/domain/notifiers/locations_notifier/locations_state_notifier.dart';
import 'package:pinpoint/domain/providers/report_provider.dart';
import 'package:pinpoint/presentation/location_add_page.dart';
import 'package:pinpoint/presentation/location_item_widget.dart';
import 'package:pinpoint/presentation/my_position_info_widget.dart';
import 'package:pinpoint/presentation/proximity_history_page.dart';

class LocationsWidget extends ConsumerWidget {
  const LocationsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(locationsStateNotifierProvider).items;

    return Scaffold(
      appBar: AppBar(
        title: const MyPositionInfoWidget(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 200),
        itemCount: items.length,
        itemBuilder: (context, index) =>
            LocationItemWidget(locationItem: items[index]),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LocationAddPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProximityHistoryPage(),
                ),
              );
            },
            icon: const Icon(Icons.trending_up_outlined),
          ),
          const SizedBox(height: 10),
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              await Clipboard.setData(
                  ClipboardData(text: ref.watch(reportProvider)));
            },
            icon: const Icon(Icons.copy_outlined),
          ),
        ],
      ),
    );
  }
}
