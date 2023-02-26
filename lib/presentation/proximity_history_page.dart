// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/domain/notifiers/proximity_notifier/proximity_notifier_state_notifier.dart';
import 'package:pinpoint/domain/notifiers/proximity_notifier/proximity_state.dart';

class ProximityHistoryPage extends ConsumerWidget {
  const ProximityHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proximityState = ref.watch(proximityStateNotifierProvider);
    final proximityInfo = proximityState.proximityInfo;
    final proximityHistory = proximityState.proximityHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proximity history'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (proximityInfo != null)
              _CurrentProximityInfo(proximityInfo: proximityInfo),
            const SizedBox(height: 30),
            const Text(
              'History',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: proximityHistory.length,
                itemBuilder: (context, index) => _ProximityHistoryItemWidget(
                  proximityInfo: proximityHistory[index],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentProximityInfo extends StatelessWidget {
  final ProximityInfo proximityInfo;

  const _CurrentProximityInfo({
    super.key,
    required this.proximityInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current position',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  proximityInfo.locationItem.name ??
                      proximityInfo.locationItem.id,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          Text(
            proximityInfo.status.name,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ProximityHistoryItemWidget extends StatelessWidget {
  final ProximityInfo proximityInfo;

  const _ProximityHistoryItemWidget({
    super.key,
    required this.proximityInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Text(
            proximityInfo.locationItem.name ?? proximityInfo.locationItem.id,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
