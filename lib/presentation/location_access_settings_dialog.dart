import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state_notifier.dart';

class LocationAccessSettingsDialog extends ConsumerWidget {
  const LocationAccessSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 3,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Please allow location access',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'The app uses GPS and WiFi signals to accurately resolve your location',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  ref
                      .read(myLocationStateNotifierProvider.notifier)
                      .openSettings();
                },
                child: const Text('Open settings'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Not now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
