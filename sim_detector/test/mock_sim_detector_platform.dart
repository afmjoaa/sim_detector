import 'dart:async';

import 'package:sim_detector_platform_interface/sim_detector_platform_interface.dart';
import 'package:test/fake.dart';

class MockSimDetectorPlatform extends Fake implements SimDetectorPlatform {


  @override
  Future<void> addSimSubscriptionChangeHandler() async {
    throw Exception("addSimSubscriptionChangeHandler exception");
  }

  @override
  Future<void> removeSimSubscriptionChangeHandler() async {
    throw Exception("removeSimSubscriptionChangeHandler exception");
  }

  @override
  Stream<dynamic> simSubscriptionChangeStream() {
    StreamController<bool> result = StreamController<bool>();
    result.add(true);
    result.add(false);
    return result.stream;
  }

}