package com.example.do_not_disturb

import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** DoNotDisturbPlugin */
class DoNotDisturbPlugin: FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  /// The EventChannel used to stream Do Not Disturb status changes to Flutter.
  private lateinit var eventChannel : EventChannel
  private lateinit var context: Context

  /// The receiver registered while a Flutter subscriber is listening to DND status changes.
  private var interruptionFilterReceiver: BroadcastReceiver? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "do_not_disturb")
    channel.setMethodCallHandler(this)
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "do_not_disturb/status")
    eventChannel.setStreamHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getDNDStatus" -> result.success(getDNDStatus())
      "openDndSettings" -> {
        openDndSettings()
        result.success(null)
      }
      "openNotificationPolicyAccessSettings" -> {
        openNotificationPolicyAccessSettings()
        result.success(null)
      }
      "isNotificationPolicyAccessGranted" -> {
        result.success(isNotificationPolicyAccessGranted())
      }
      "setInterruptionFilter" -> {
        val interruptionFilter: Int? = call.arguments()
        if(interruptionFilter == null) {
          result.error("INVALID_ARGUMENT", "Interruption filter is required", null)
        }
        else{
          result.success(setInterruptionFilter(interruptionFilter))
        }
      }
      else -> result.notImplemented()
    }

  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
    unregisterInterruptionFilterReceiver()
  }

  /// Called when Flutter starts listening to the DND status EventChannel.
  ///
  /// Registers a [BroadcastReceiver] for [NotificationManager.ACTION_INTERRUPTION_FILTER_CHANGED]
  /// and emits the current status immediately so subscribers have an initial value.
  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    if (events == null) {
      return
    }
    // Ensure a stale receiver from a previous listen is torn down first.
    unregisterInterruptionFilterReceiver()

    val receiver = object : BroadcastReceiver() {
      override fun onReceive(receiverContext: Context?, intent: Intent?) {
        if (intent?.action == NotificationManager.ACTION_INTERRUPTION_FILTER_CHANGED) {
          events.success(getDNDStatus())
        }
      }
    }
    interruptionFilterReceiver = receiver
    context.registerReceiver(
      receiver,
      IntentFilter(NotificationManager.ACTION_INTERRUPTION_FILTER_CHANGED)
    )

    // Emit the current status so subscribers immediately know the current state.
    events.success(getDNDStatus())
  }

  /// Called when Flutter stops listening to the DND status EventChannel.
  ///
  /// Unregisters the [BroadcastReceiver] to avoid leaks.
  override fun onCancel(arguments: Any?) {
    unregisterInterruptionFilterReceiver()
  }

  private fun unregisterInterruptionFilterReceiver() {
    interruptionFilterReceiver?.let {
      try {
        context.unregisterReceiver(it)
      } catch (e: IllegalArgumentException) {
        // Receiver was already unregistered; safe to ignore.
      }
    }
    interruptionFilterReceiver = null
  }


  private fun getDNDStatus(): Int {
    val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    return notificationManager.currentInterruptionFilter
  }

  private fun openDndSettings() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      val intent = Intent(Settings.ACTION_ZEN_MODE_PRIORITY_SETTINGS)
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      context.startActivity(intent)
    }
  }

  private fun openNotificationPolicyAccessSettings() {
    val intent = Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    context.startActivity(intent)
  }

  private fun isNotificationPolicyAccessGranted(): Boolean {
      val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
      return notificationManager.isNotificationPolicyAccessGranted
  }

  private fun setInterruptionFilter(interruptionFilter: Int): Boolean {
    val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    if (notificationManager.isNotificationPolicyAccessGranted) {
      notificationManager.setInterruptionFilter(interruptionFilter)
      return true
    }
    return false
  }
}
