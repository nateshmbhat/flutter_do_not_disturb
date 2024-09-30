import 'package:do_not_disturb/do_not_disturb_interruption.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:do_not_disturb/do_not_disturb_platform_interface.dart';
import 'package:do_not_disturb/do_not_disturb_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDoNotDisturbPlatform
    with MockPlatformInterfaceMixin
    implements DoNotDisturbPlatform {
  @override
  Future<InterruptionFilter> getDNDStatus() {
    // TODO: implement getDNDStatus
    throw UnimplementedError();
  }

  @override
  Future<bool> isDndEnabled() {
    // TODO: implement isDndEnabled
    throw UnimplementedError();
  }

  @override
  Future<void> openDndSettings() {
    // TODO: implement openDndSettings
    throw UnimplementedError();
  }

  @override
  Future<void> openNotificationPolicyAccessSettings() {
    // TODO: implement openNotificationPolicyAccessSettings
    throw UnimplementedError();
  }
}

void main() {
  final DoNotDisturbPlatform initialPlatform = DoNotDisturbPlatform.instance;

  test('$MethodChannelDoNotDisturb is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDoNotDisturb>());
  });

  // test('getPlatformVersion', () async {
  //   DoNotDisturbPlugin doNotDisturbPlugin = DoNotDisturbPlugin();
  //   MockDoNotDisturbPlatform fakePlatform = MockDoNotDisturbPlatform();
  //   DoNotDisturbPlatform.instance = fakePlatform;

  //   expect(await doNotDisturbPlugin.getPlatformVersion(), '42');
  // });
}
