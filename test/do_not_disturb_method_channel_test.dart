import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:do_not_disturb/do_not_disturb_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelDoNotDisturb platform = MethodChannelDoNotDisturb();
  const MethodChannel channel = MethodChannel('do_not_disturb');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    // expect(await platform.getPlatformVersion(), '42');
  });
}
