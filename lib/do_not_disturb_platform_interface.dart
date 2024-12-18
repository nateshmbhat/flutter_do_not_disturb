import 'package:do_not_disturb/types.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'do_not_disturb_method_channel.dart';

/// The interface that has implementations of do_not_disturb plugin.
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

  /// Retrieves the current Do Not Disturb status.
  ///
  /// Returns the current [InterruptionFilter] status.
  Future<InterruptionFilter> getDNDStatus();

  /// Checks if the Notification Policy Access is granted.
  ///
  /// Returns `true` if access is granted, otherwise `false`.
  Future<bool> isNotificationPolicyAccessGranted();

  /// Opens the Do Not Disturb settings.
  ///
  /// This method should open the DND settings on the platform.
  Future<void> openDndSettings();

  /// Opens the Notification Policy Access settings.
  ///
  /// This method should open the notification policy access settings on the platform.
  Future<void> openNotificationPolicyAccessSettings();

  /// Sets the Interruption Filter for Do Not Disturb.
  ///
  /// This method should set the given [InterruptionFilter] on the platform.
  Future<void> setInterruptionFilter(InterruptionFilter filter);
}
