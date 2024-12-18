import 'dart:io';

import 'types.dart';
import 'do_not_disturb_platform_interface.dart';

/// The DoNotDisturbPlugin class is the main class of the plugin.
class DoNotDisturbPlugin {
  /// Returns true if DND is enabled.
  /// Returns `false` if the platform is iOS, otherwise returns the DND status.
  Future<bool> isDndEnabled() async {
    if (Platform.isIOS) {
      return false;
    }
    final dndStatus = await getDNDStatus();
    return dndStatus != InterruptionFilter.all;
  }

  /// Retrieves the current Do Not Disturb status.
  ///
  /// Returns `InterruptionFilter.unknown` if the platform is iOS, otherwise returns the DND status on android.
  Future<InterruptionFilter> getDNDStatus() async {
    if (Platform.isIOS) {
      return InterruptionFilter.unknown;
    }
    return DoNotDisturbPlatform.instance.getDNDStatus();
  }

  /// Opens the Do Not Disturb settings.
  ///
  /// Does nothing if the platform is iOS, otherwise opens the DND settings from the platform instance.
  Future<void> openDndSettings() async {
    if (Platform.isIOS) {
      return;
    }
    return DoNotDisturbPlatform.instance.openDndSettings();
  }

  /// Opens the Notification Policy Access settings.
  ///
  /// Does nothing if the platform is iOS, otherwise opens the notification policy access settings from the platform instance.
  Future<void> openNotificationPolicyAccessSettings() async {
    if (Platform.isIOS) {
      return;
    }
    return DoNotDisturbPlatform.instance.openNotificationPolicyAccessSettings();
  }

  /// Checks if the Notification Policy Access is granted.
  ///
  /// Returns `false` if the platform is iOS, otherwise returns the access status from the platform instance.
  Future<bool> isNotificationPolicyAccessGranted() async {
    if (Platform.isIOS) {
      return false;
    }
    return DoNotDisturbPlatform.instance.isNotificationPolicyAccessGranted();
  }

  /// Sets the Interruption Filter for Do Not Disturb.
  ///
  /// Does nothing if the platform is iOS, otherwise sets the interruption filter from the platform instance.
  Future<void> setInterruptionFilter(InterruptionFilter filter) async {
    if (Platform.isIOS) {
      return;
    }
    return DoNotDisturbPlatform.instance.setInterruptionFilter(filter);
  }
}
