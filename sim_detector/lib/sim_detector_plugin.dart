import 'dart:io';

import 'package:sim_detector/sim_detector_android.dart';
import 'package:sim_detector_platform_interface/sim_detector_platform_interface.dart';

SimDetectorPlatform get _platform {
  if(Platform.isAndroid){
    SimDetectorPlatform.instance = SimDetectorAndroid();
  }
  return SimDetectorPlatform.instance;
}

Stream<dynamic>? get simSubscriptionChangeStream => _platform.simSubscriptionChangeStream();

Future<void> addSimSubscriptionChangeHandler() async {
  return await _platform.addSimSubscriptionChangeHandler();
}

Future<void> removeSimSubscriptionChangeHandler() async {
  return await _platform.removeSimSubscriptionChangeHandler();
}
