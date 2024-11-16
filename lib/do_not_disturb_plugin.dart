import 'dart:io';

import 'types.dart';
import 'do_not_disturb_platform_interface.dart';

class DoNotDisturbPlugin {
  Future<bool> isDndEnabled() async {
    if (Platform.isIOS) {
      return false;
    }
    final dndStatus = await getDNDStatus();
    return dndStatus != InterruptionFilter.all;
  }

  Future<InterruptionFilter> getDNDStatus() async {
    if (Platform.isIOS) {
      return InterruptionFilter.unknown;
    }
    return DoNotDisturbPlatform.instance.getDNDStatus();
  }

  Future<void> openDndSettings() async {
    if (Platform.isIOS) {
      return;
    }
    return DoNotDisturbPlatform.instance.openDndSettings();
  }

  Future<void> openNotificationPolicyAccessSettings() async {
    if (Platform.isIOS) {
      return;
    }
    return DoNotDisturbPlatform.instance.openNotificationPolicyAccessSettings();
  }

  Future<bool> isNotificationPolicyAccessGranted() async {
    if (Platform.isIOS) {
      return false;
    }
    return DoNotDisturbPlatform.instance.isNotificationPolicyAccessGranted();
  }

  Future<void> setInterruptionFilter(InterruptionFilter filter) async {
    if (Platform.isIOS) {
      return;
    }
    return DoNotDisturbPlatform.instance.setInterruptionFilter(filter);
  }
}
