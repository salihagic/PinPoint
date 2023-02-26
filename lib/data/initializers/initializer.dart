import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Initializer {
  Ref ref;

  Initializer(this.ref);

  Future<void> init();
}
