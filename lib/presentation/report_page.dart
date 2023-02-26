import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/domain/providers/report_provider.dart';

class ReportPage extends ConsumerWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(reportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report page'),
      ),
      body: SelectionArea(
        child: Text(report),
      ),
    );
  }
}
