import 'package:flutter/material.dart';
import 'package:do_not_disturb/do_not_disturb.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _dndPlugin = DoNotDisturbPlugin();

  @override
  void initState() {
    super.initState();
  }

  bool _isDndEnabled = false;
  InterruptionFilter _dndStatus = InterruptionFilter.unknown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DND Plugin Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _checkDndEnabled,
              child: Text('Check if DND is Enabled'),
            ),
            SizedBox(height: 10),
            Text('DND Enabled: $_isDndEnabled'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getDndStatus,
              child: Text('Get DND Status'),
            ),
            SizedBox(height: 10),
            Text('DND Status: ${_dndStatus.toString()}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openDndSettings,
              child: Text('Open DND Settings'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openNotificationPolicyAccessSettings,
              child: Text('Open Notification Policy Access Settings'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkDndEnabled() async {
    try {
      final bool isDndEnabled = await _dndPlugin.isDndEnabled();
      setState(() {
        _isDndEnabled = isDndEnabled;
      });
    } catch (e) {
      print('Error checking DND status: $e');
    }
  }

  Future<void> _getDndStatus() async {
    try {
      final InterruptionFilter status = await _dndPlugin.getDNDStatus();
      setState(() {
        _dndStatus = status;
      });
    } catch (e) {
      print('Error getting DND status: $e');
    }
  }

  Future<void> _openDndSettings() async {
    try {
      await _dndPlugin.openDndSettings();
    } catch (e) {
      print('Error opening DND settings: $e');
    }
  }

  Future<void> _openNotificationPolicyAccessSettings() async {
    try {
      await _dndPlugin.openNotificationPolicyAccessSettings();
    } catch (e) {
      print('Error opening notification policy access settings: $e');
    }
  }
}
