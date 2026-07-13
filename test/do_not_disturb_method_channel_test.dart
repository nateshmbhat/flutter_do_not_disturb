import 'package:do_not_disturb/do_not_disturb_method_channel.dart';
import 'package:do_not_disturb/types.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MethodChannelDoNotDisturb platform = MethodChannelDoNotDisturb();

  group('getDNDStatus', () {
    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        platform.methodChannel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getDNDStatus') {
            return InterruptionFilter.priority.value;
          }
          return null;
        },
      );
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(platform.methodChannel, null);
    });

    test('maps the native int to an InterruptionFilter', () async {
      expect(await platform.getDNDStatus(), InterruptionFilter.priority);
    });
  });

  group('onDndStatusChanged', () {
    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockStreamHandler(
        platform.eventChannel,
        MockStreamHandler.inline(
          onListen: (Object? arguments, MockStreamHandlerEventSink events) {
            // Mimic the native side: emit the current status, then a change.
            // The real stream never completes, so we do not call endOfStream.
            events.success(InterruptionFilter.none.value);
            events.success(InterruptionFilter.all.value);
          },
        ),
      );
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockStreamHandler(platform.eventChannel, null);
    });

    test('emits InterruptionFilter values from the native event channel',
        () async {
      await expectLater(
        platform.onDndStatusChanged,
        emitsInOrder([
          InterruptionFilter.none,
          InterruptionFilter.all,
        ]),
      );
    });
  });
}
