import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:pinpoint/presentation/my_position_info_widget.dart';

class MyPositionInfoWrapper extends ConsumerWidget {
  final Widget? child;

  const MyPositionInfoWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const MyPositionInfoWidget(),
      ),
      body: child,
    );
  }
}
