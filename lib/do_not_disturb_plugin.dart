import 'do_not_disturb_interruption.dart';
import 'do_not_disturb_platform_interface.dart';

class DoNotDisturbPlugin {
  Future<bool> isDndEnabled() async {
    final dndStatus = await getDNDStatus();
    return dndStatus != InterruptionFilter.all;
  }

  Future<InterruptionFilter> getDNDStatus() async {
    return DoNotDisturbPlatform.instance.getDNDStatus();
  }

  Future<void> openDndSettings() async {
    return DoNotDisturbPlatform.instance.openDndSettings();
  }

  Future<void> openNotificationPolicyAccessSettings() async {
    return DoNotDisturbPlatform.instance.openNotificationPolicyAccessSettings();
  }
}
