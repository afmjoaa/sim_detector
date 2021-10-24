import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'sim_detector_platform_interface.dart';

class SimDetectorDefaultImplementation extends SimDetectorPlatform{

  final EventChannel _eventChannel = const EventChannel('sim_detector_plugin/simChangeEvent');
  final MethodChannel _methodChannel = const MethodChannel('sim_detector_plugin/methodCall');

  @override
  Future<void> addSimSubscriptionChangeHandler() async {
    await _methodChannel.invokeMethod('addSimSubscriptionChangeHandler');
  }

  @override
  Future<void> removeSimSubscriptionChangeHandler() async {
    return await _methodChannel.invokeMethod('removeSimSubscriptionChangeHandler');
  }

  @override
  Stream<dynamic>? simSubscriptionChangeStream() =>
      _eventChannel.receiveBroadcastStream().distinct((previous, next) {
        if (DeepCollectionEquality().equals(previous, next)) {
          return true;
        } else {
          return false;
        }
      });
}