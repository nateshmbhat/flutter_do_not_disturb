import 'package:do_not_disturb/types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'do_not_disturb_platform_interface.dart';

/// An implementation of [DoNotDisturbPlatform] that uses method channels.
class MethodChannelDoNotDisturb extends DoNotDisturbPlatform {
  /// The method channel used to communicate with the platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('do_not_disturb');

  /// The event channel used to receive Do Not Disturb status changes.
  @visibleForTesting
  final eventChannel = const EventChannel('do_not_disturb/status');

  Stream<InterruptionFilter>? _onDndStatusChanged;

  @override
  Future<InterruptionFilter> getDNDStatus() async {
    final int? status = await methodChannel.invokeMethod<int>('getDNDStatus');
    return InterruptionFilter.fromValue(status ?? 0);
  }

  @override
  Stream<InterruptionFilter> get onDndStatusChanged {
    _onDndStatusChanged ??= eventChannel
        .receiveBroadcastStream()
        .map((event) => InterruptionFilter.fromValue((event as int?) ?? 0));
    return _onDndStatusChanged!;
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
