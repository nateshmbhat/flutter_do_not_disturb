import 'package:do_not_disturb/do_not_disturb_interruption.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'do_not_disturb_platform_interface.dart';

/// An implementation of [DoNotDisturbPlatform] that uses method channels.
class MethodChannelDoNotDisturb extends DoNotDisturbPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('do_not_disturb');

  @override
  Future<bool> isDndEnabled() async {
    final bool? enabled =
        await methodChannel.invokeMethod<bool>('isDndEnabled');
    return enabled ?? false;
  }

  @override
  Future<InterruptionFilter> getDNDStatus() async {
    final int? status = await methodChannel.invokeMethod<int>('getDNDStatus');
    return InterruptionFilter.fromValue(status ?? 0);
  }

  @override
  Future<void> openDndSettings() async {
    await methodChannel.invokeMethod<void>('openDndSettings');
  }

  @override
  Future<void> openNotificationPolicyAccessSettings() async {
    await methodChannel
        .invokeMethod<void>('openNotificationPolicyAccessSettings');
  }
}
