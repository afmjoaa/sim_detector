import '../pigeon_generated/platform_listener_api.dart';

typedef SubscribedSimInformationReceived = void Function(SubscribedSimInformation flutterInitBlock);

class PlatformListenerApiHandler extends PlatformListenerApi {

  final SubscribedSimInformationReceived callback;

  PlatformListenerApiHandler(this.callback);

  @override
  void emitSimInformation(SubscribedSimInformation subscribedSimInformation) {
    callback(subscribedSimInformation);
  }

}