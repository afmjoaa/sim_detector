// Autogenerated from Pigeon (v1.0.7), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

class SubscribedSimInformation {
  int? simSlotZeroSubscriptionId;
  int? simSlotOneSubscriptionId;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['simSlotZeroSubscriptionId'] = simSlotZeroSubscriptionId;
    pigeonMap['simSlotOneSubscriptionId'] = simSlotOneSubscriptionId;
    return pigeonMap;
  }

  static SubscribedSimInformation decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return SubscribedSimInformation()
      ..simSlotZeroSubscriptionId = pigeonMap['simSlotZeroSubscriptionId'] as int?
      ..simSlotOneSubscriptionId = pigeonMap['simSlotOneSubscriptionId'] as int?;
  }
}

class _PlatformListenerApiCodec extends StandardMessageCodec {
  const _PlatformListenerApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is SubscribedSimInformation) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return SubscribedSimInformation.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}
abstract class PlatformListenerApi {
  static const MessageCodec<Object?> codec = _PlatformListenerApiCodec();

  void emitSimInformation(SubscribedSimInformation subscribedSimInformation);
  static void setup(PlatformListenerApi? api) {
    {
      const BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PlatformListenerApi.emitSimInformation', codec);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PlatformListenerApi.emitSimInformation was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final SubscribedSimInformation? arg_subscribedSimInformation = args[0] as SubscribedSimInformation?;
          assert(arg_subscribedSimInformation != null, 'Argument for dev.flutter.pigeon.PlatformListenerApi.emitSimInformation was null, expected non-null SubscribedSimInformation.');
          api.emitSimInformation(arg_subscribedSimInformation!);
          return;
        });
      }
    }
  }
}
