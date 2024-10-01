<p align="center">
  <img src="https://raw.githubusercontent.com/nateshmbhat/flutter_do_not_disturb/main/.github/logo.png" width="250px">
</p>
<h2 align="center">Powerful and Intuitive Do Not Disturb Management for Flutter</h2>

[![](https://img.shields.io/pub/v/do_not_disturb)](https://pub.dev/packages/do_not_disturb)
[![](https://img.shields.io/badge/package-flutter-blue)](https://github.com/nateshmbhat/flutter_do_not_disturb)
[![](https://img.shields.io/github/license/nateshmbhat/flutter_do_not_disturb)](https://github.com/nateshmbhat/flutter_do_not_disturb)
[![](https://img.shields.io/github/languages/code-size/nateshmbhat/flutter_do_not_disturb)](https://github.com/nateshmbhat/flutter_do_not_disturb)
[![](https://img.shields.io/badge/platform-android-brightgreen)](https://github.com/nateshmbhat/flutter_do_not_disturb)
[![](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2Fnateshmbhat%2Fflutter_do_not_disturb)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fnateshmbhat%2Fflutter_do_not_disturb)

**do_not_disturb** is a Flutter plugin for seamlessly managing Do Not Disturb settings on Android devices.

## Features

- 🎧 Check if Do Not Disturb (DND) or Zen mode is enabled
- ⚙️ Open DND settings screen directly from your app
- 📊 Get detailed DND status (All, Priority, None, Alarms)
- 🗝️ Check if Notification Policy access is granted
- 🔐 Open Notification Policy Settings screen.
- 🤳 Allows Setting DND mode directly from your app
- 🔥 No extra permissions needed if you're not setting DND mode from code
- 🎭 Elegant enum-based API for interruption filter states
- 📱 Optimized for Android devices
- 💙 Simple, powerful, & intuitive API

## Install

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  do_not_disturb: <latest-version>
```

> Get the [latest version number here](https://pub.dev/packages/do_not_disturb#instal)

## Usage

```dart
import 'package:flutter_do_not_disturb/flutter_do_not_disturb.dart';

final dndPlugin = DoNotDisturbPlugin();

// Check if DND is enabled
bool isDndEnabled = await dndPlugin.isDndEnabled();
print('DND Enabled: $isDndEnabled');

// Get current DND status
InterruptionFilter status = await dndPlugin.getDNDStatus();
print('Current DND Status: $status');

// Open DND settings
await dndPlugin.openDndSettings();

// Open notification policy access settings
await dndPlugin.openNotificationPolicyAccessSettings();

// Set DND mode (requires permission)
if (await dndPlugin.isNotificationPolicyAccessGranted()) {
  await dndPlugin.setInterruptionFilter(InterruptionFilter.priority);
} else {
  // Guide user to grant permission
  await dndPlugin.openNotificationPolicyAccessSettings();
  // Inform user to grant permission and return to the app
}
```

This setup ensures that your app can both read the DND status and, with proper permissions, modify it. Always respect user privacy and system settings when using these features.

## Permissions and Setup

### Basic Usage

For basic functionality (checking DND status and opening settings), no special permissions are required.

### Setting DND Mode

If you want to programmatically set the DND mode or interruption filter, you need to:

1. Add the following permission to your `AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY"/>
```

2. Whitelist your application in the Notification Access Policy settings.

Here's how to guide your users through this process:

```dart
// Check if the app has notification policy access
bool hasAccess = await dndPlugin.isNotificationPolicyAccessGranted();

if (!hasAccess) {
  // Open the settings screen for the user to grant access
  await dndPlugin.openNotificationPolicyAccessSettings();
  // Inform the user to grant access and return to the app
}

// Once access is granted, you can set the DND mode
await dndPlugin.setInterruptionFilter(InterruptionFilter.priority);
```

> Note: Setting DND mode requires user action to grant permission. Always check for permission and guide the user to the settings if necessary.

## Interruption Filter States

The plugin uses an enhanced enum `InterruptionFilter` to represent DND states:

```dart
enum InterruptionFilter {
  unknown(0),
  all(1),
  priority(2),
  none(3),
  alarms(4);

  final int value;
  const InterruptionFilter(this.value);

  static InterruptionFilter fromValue(int value) {
    return InterruptionFilter.values.firstWhere(
      (filter) => filter.value == value,
      orElse: () => InterruptionFilter.unknown,
    );
  }
}
```

This allows for type-safe and intuitive handling of DND states in your app.

## Example

<p align="center">
  <video controls src="https://github.com/user-attachments/assets/2d05a54e-1344-4d29-9021-272095bda5e6" </video>
</p>

Check out the [example](https://github.com/nateshmbhat/flutter_do_not_disturb/tree/master/example) directory for a complete sample app using the flutter_do_not_disturb plugin.

## Contributing

Contributions are welcome! If you find a bug or want a feature, please open an issue.

## License

This project is licensed under the Mozilla Public License - see the [LICENSE](LICENSE) file for details.

---

### [Documentation & Samples](https://pub.dev/documentation/do_not_disturb/latest/) 📖

### 💖 Show your love

If you find this plugin useful, consider supporting it by giving it a star on [GitHub](https://github.com/nateshmbhat/flutter_do_not_disturb) and liking it on [pub.dev](https://pub.dev/packages/do_not_disturb).
