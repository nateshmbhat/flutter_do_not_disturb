import 'package:do_not_disturb/types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'do_not_disturb_platform_interface.dart';

/// An implementation of [DoNotDisturbPlatform] that uses method channels.
class MethodChannelDoNotDisturb extends DoNotDisturbPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('do_not_disturb');

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

  @override
  Future<bool> isNotificationPolicyAccessGranted() async {
    final granted = await methodChannel
        .invokeMethod<bool>('isNotificationPolicyAccessGranted');
    return granted ?? false;
  }

  @override
  Future<void> setInterruptionFilter(InterruptionFilter filter) {
    return methodChannel.invokeMethod<void>(
        'setInterruptionFilter', filter.value);
  }
}
