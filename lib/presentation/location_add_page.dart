import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/domain/entities/location_point.dart';
import 'package:pinpoint/domain/enumerations/location_item_type.dart';
import 'package:pinpoint/domain/notifiers/location_add_notifier/location_add_state.dart';
import 'package:pinpoint/domain/notifiers/location_add_notifier/location_add_state_notifier.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state_notifier.dart';
import 'package:pinpoint/presentation/common/text_input.dart';
import 'package:pinpoint/presentation/my_position_info_widget.dart';

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
                  children: [
                    const SizedBox(height: 20),
                    const MyPositionInfoWidget(),
                    const SizedBox(height: 15),
                    // const _Type(),
                    // const SizedBox(height: 20),
                    const _Name(),
                    const SizedBox(height: 20),
                    const _Note(),
                    const SizedBox(height: 20),
                    Container(color: Theme.of(context).primaryColor, height: 1),
                    const SizedBox(height: 20),
                    const _InnerRadius(),
                    const SizedBox(height: 20),
                    const _OuterRadius(),
                    const SizedBox(height: 200),
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

class _Type extends ConsumerWidget {
  const _Type({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(locationAddStateNotifierProvider).item;

    return DropdownButton(
      isExpanded: true,
      items: LocationItemType.values
          .map(
            (type) => DropdownMenuItem(
              value: type,
              child: Text(type.name),
            ),
          )
          .toList(),
      value: item.type,
      onChanged: (type) => ref
          .read(locationAddStateNotifierProvider.notifier)
          .update(item.copyWith(type: type)),
    );
  }
}

class _Name extends ConsumerWidget {
  const _Name({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(locationAddStateNotifierProvider).item;

    return TextInput(
      hintText: 'Name',
      onChanged: (text) => ref
          .read(locationAddStateNotifierProvider.notifier)
          .update(item.copyWith(name: text)),
    );
  }
}

class _Note extends ConsumerWidget {
  const _Note({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(locationAddStateNotifierProvider).item;

    return TextInput(
      hintText: 'Note',
      minLines: 5,
      onChanged: (text) => ref
          .read(locationAddStateNotifierProvider.notifier)
          .update(item.copyWith(name: text)),
    );
  }
}

class _InnerRadius extends ConsumerWidget {
  const _InnerRadius({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(locationAddStateNotifierProvider).item;

    return TextInput(
      type: TextInputType.number,
      hintText: 'Inner radius (meters)',
      onChanged: (text) => ref
          .read(locationAddStateNotifierProvider.notifier)
          .update(item.copyWith(innerRadius: double.tryParse(text))),
    );
  }
}

class _OuterRadius extends ConsumerWidget {
  const _OuterRadius({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(locationAddStateNotifierProvider).item;

    return TextInput(
      type: TextInputType.number,
      hintText: 'Outer radius (meters)',
      onChanged: (text) => ref
          .read(locationAddStateNotifierProvider.notifier)
          .update(item.copyWith(outerRadius: double.tryParse(text))),
    );
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myLocation = ref.watch(myLocationStateNotifierProvider).myLocation;

    if (myLocation != null) {
      return InkWell(
        onTap: () => ref
            .read(locationAddStateNotifierProvider.notifier)
            .save(LocationPoint.fromPosition(myLocation)),
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

    return const SizedBox();
  }
}
