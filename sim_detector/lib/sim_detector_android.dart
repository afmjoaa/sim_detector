import 'dart:async';

import 'package:sim_detector_platform_interface/sim_detector_platform_interface.dart';
import 'pigeon_generated/host_initiated_api.dart';
import 'pigeon_generated/platform_listener_api.dart';
import 'handler/platform_listener_api_handler.dart';
import 'package:collection/collection.dart';

class SimDetectorAndroid extends SimDetectorPlatform {
  final StreamController<SubscribedSimInformation> _subscribedSimInformationStream = StreamController.broadcast();
  static late HostInitiatedApi _hostInitiatedApi = HostInitiatedApi();

  SimDetectorAndroid () {
    PlatformListenerApi.setup(PlatformListenerApiHandler((SubscribedSimInformation subscribedSimInformation) {
      _subscribedSimInformationStream.add(subscribedSimInformation);
    }));
  }

  @override
  Future<void> addSimSubscriptionChangeHandler() async {
    return await _hostInitiatedApi.addSimSubscriptionChangeHandler();
  }

  @override
  Future<void> removeSimSubscriptionChangeHandler() async {
    return await _hostInitiatedApi.removeSimSubscriptionChangeHandler();
  }

  @override
  Stream<dynamic>? simSubscriptionChangeStream() {
    return _subscribedSimInformationStream.stream.distinct((previous, next) {
      if (DeepCollectionEquality().equals(previous, next)) {
        return true;
      } else {
        return false;
      }
    });
  }
}