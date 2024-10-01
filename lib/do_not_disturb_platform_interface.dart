import 'package:do_not_disturb/types.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'do_not_disturb_method_channel.dart';

abstract class DoNotDisturbPlatform extends PlatformInterface {
  /// Constructs a DoNotDisturbPlatform.
  DoNotDisturbPlatform() : super(token: _token);

  static final Object _token = Object();

  static DoNotDisturbPlatform _instance = MethodChannelDoNotDisturb();

  /// The default instance of [DoNotDisturbPlatform] to use.
  ///
  /// Defaults to [MethodChannelDoNotDisturb].
  static DoNotDisturbPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DoNotDisturbPlatform] when
  /// they register themselves.
  static set instance(DoNotDisturbPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<InterruptionFilter> getDNDStatus();
  Future<bool> isNotificationPolicyAccessGranted();
  Future<void> openDndSettings();
  Future<void> openNotificationPolicyAccessSettings();
  Future<void> setInterruptionFilter(InterruptionFilter filter);
}
