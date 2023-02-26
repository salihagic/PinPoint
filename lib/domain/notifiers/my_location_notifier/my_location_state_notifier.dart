import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:pinpoint/data/repositories/my_location_repository.dart';
import 'package:pinpoint/domain/notifiers/my_location_notifier/my_location_state.dart';

final myLocationStateNotifierProvider =
    StateNotifierProvider<MyLocationStateNotifier, MyLocationState>(
  (ref) => MyLocationStateNotifier(
    myLocationRepository: ref.read(myLocationRepositoryProvider),
  ),
);

class MyLocationStateNotifier extends StateNotifier<MyLocationState> {
  final MyLocationRepository myLocationRepository;

  late StreamSubscription _myLocationStreamSubscription;

  MyLocationStateNotifier({
    required this.myLocationRepository,
  }) : super(MyLocationState.initial()) {
    _tryInit();
  }

  Future<void> init() async {
    final permission = await myLocationRepository.init();
    final myLocation = await myLocationRepository.getMyLocation();

    state = state.copyWith(
      permission: permission,
      myLocation: myLocation,
    );

    if (await myLocationRepository.isEnabledAndAllowed()) {
      _myLocationStreamSubscription =
          myLocationRepository.getMyLocationStream().listen((myLocation) {
        state = state.copyWith(myLocation: myLocation);
      });
    }
  }

  Future<void> _tryInit() async {
    if (await myLocationRepository.isEnabledAndAllowed()) {
      await init();
    }
  }

  Future<void> openSettings() async =>
      await myLocationRepository.openSettings();

  @override
  void dispose() {
    _myLocationStreamSubscription.cancel();

    super.dispose();
  }
}
