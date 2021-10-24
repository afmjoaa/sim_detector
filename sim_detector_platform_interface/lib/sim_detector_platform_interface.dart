import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import './sim_detector_default_implementation.dart';

/// The interface that implementations of sim_detector must implement.
///
/// Platform implementations should extend this class rather than implement it as `SimDetector`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
abstract class SimDetectorPlatform extends PlatformInterface {
  static SimDetectorPlatform _instance = SimDetectorDefaultImplementation();

  static final Object _token = Object();

  /// The default instance of [SimDetectorPlatform] to use.
  ///
  /// Defaults to [SimDetectorDefaultImplementation].
  static SimDetectorPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [SimDetectorPlatform] when they register themselves.
  static set instance(SimDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Constructs a SimDetectorPlatform.
  SimDetectorPlatform() : super(token: _token);

  Future<void> addSimSubscriptionChangeHandler() async {
    throw UnimplementedError('addSimSubscriptionChangeHandler() has not been implemented.');
  }

  Future<void> removeSimSubscriptionChangeHandler() async {
    throw UnimplementedError('removeSimSubscriptionChangeHandler() has not been implemented.');
  }

  Stream<dynamic>? simSubscriptionChangeStream() async* {
    throw UnimplementedError('simSubscriptionChangeStream() has not been implemented.');
  }
}