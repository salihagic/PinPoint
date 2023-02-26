// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/domain/entities/location_point.dart';
import 'package:pinpoint/domain/notifiers/location_add_notifier/location_add_state.dart';
import 'package:pinpoint/domain/notifiers/location_add_notifier/location_add_state_notifier.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state_notifier.dart';
import 'package:pinpoint/presentation/common/text_input.dart';
import 'package:pinpoint/presentation/my_position_info_widget.dart';
import 'package:pinpoint/presentation/position_info_widget.dart';

class LocationAddPage extends ConsumerWidget {
  const LocationAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      locationAddStateNotifierProvider,
      (previous, next) {
        if (next.status == LocationAddStateStatus.submittingSuccess) {
          Navigator.of(context).pop();
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new location'),
      ),
      body: Form(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: const [
                    SizedBox(height: 20),
                    _Name(),
                    SizedBox(height: 20),
                    _InnerRadius(),
                    SizedBox(height: 20),
                    _OuterRadius(),
                    SizedBox(height: 20),
                    _MyPositionWidget(),
                    SizedBox(height: 200),
                  ],
                ),
              ),
            ),
            const _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _Name extends ConsumerWidget {
  const _Name({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(locationAddStateNotifierProvider).model;

    return TextInput(
      hintText: 'Name',
      onChanged: (text) => ref
          .read(locationAddStateNotifierProvider.notifier)
          .update(model.copyWith(name: text)),
    );
  }
}

class _InnerRadius extends ConsumerWidget {
  const _InnerRadius({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(locationAddStateNotifierProvider).model;

    return TextInput(
      type: TextInputType.number,
      hintText: 'Inner radius (meters)',
      onChanged: (text) => ref
          .read(locationAddStateNotifierProvider.notifier)
          .update(model.copyWith(innerRadius: double.tryParse(text))),
    );
  }
}

class _OuterRadius extends ConsumerWidget {
  const _OuterRadius({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(locationAddStateNotifierProvider).model;

    return TextInput(
      type: TextInputType.number,
      hintText: 'Outer radius (meters)',
      onChanged: (text) => ref
          .read(locationAddStateNotifierProvider.notifier)
          .update(model.copyWith(outerRadius: double.tryParse(text))),
    );
  }
}

class _MyPositionWidget extends ConsumerWidget {
  const _MyPositionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(child: MyPositionInfoWidget()),
            const SizedBox(width: 20),
            Consumer(
              builder: (context, ref, child) {
                final myLocation =
                    ref.watch(myLocationStateNotifierProvider).myLocation;
                final myLocationPoint = myLocation != null
                    ? LocationPoint.fromPosition(myLocation)
                    : null;
                final lastPoint =
                    ref.watch(locationAddStateNotifierProvider).lastPoint;

                final isLastPointSameAsCurrent = myLocationPoint != null
                    ? lastPoint == myLocationPoint
                    : true;

                return InkWell(
                  onTap: () => isLastPointSameAsCurrent
                      ? null
                      : ref
                          .read(locationAddStateNotifierProvider.notifier)
                          .addPoint(myLocationPoint),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isLastPointSameAsCurrent
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Add point',
                      style: TextStyle(
                          color: isLastPointSameAsCurrent
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(width: 20),
        Consumer(
          builder: (context, ref, child) {
            final points =
                ref.watch(locationAddStateNotifierProvider).model.points;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: points
                  .map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: PositionInfoWidget(
                        latitude: point.latitude.toString(),
                        longitude: point.longitude.toString(),
                        withBorder: true,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(locationAddStateNotifierProvider.notifier).save(),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
