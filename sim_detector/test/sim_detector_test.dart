import 'package:flutter_test/flutter_test.dart';

import 'mock_sim_detector_platform.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('sim_detector', () {
    late MockSimDetectorPlatform fakePlatform;
    setUp(() async {
      fakePlatform = MockSimDetectorPlatform();
    });

    test('simSubscriptionChangeStream should return true for first item', () async {
      bool result = await fakePlatform.simSubscriptionChangeStream().first;
      expect(result, true);
    });

    test('simSubscriptionChangeStream should return false for second item', () async {
      bool result = await fakePlatform.simSubscriptionChangeStream().skip(1).first;
      expect(result, false);
    });

    test('addSimSubscriptionChangeHandler should throw exception', () async {
      expect(() async => await fakePlatform.addSimSubscriptionChangeHandler(), throwsException);
    });

    test('removeSimSubscriptionChangeHandler should throw exception', () async {
      expect(() async => await fakePlatform.removeSimSubscriptionChangeHandler(), throwsException);
    });
  });


}


