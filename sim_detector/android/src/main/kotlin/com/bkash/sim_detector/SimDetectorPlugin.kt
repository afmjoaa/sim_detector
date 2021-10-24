package com.bkash.sim_detector

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class SimDetectorPlugin: FlutterPlugin, HostApi.HostInitiatedApi {
  private lateinit var subscriptionChangeStreamHandler : SubscriptionChangeStreamHandler

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    HostApi.HostInitiatedApi.setup(flutterPluginBinding.binaryMessenger, this)
    subscriptionChangeStreamHandler = SubscriptionChangeStreamHandler(flutterPluginBinding.applicationContext) {
      PlatformApi.PlatformListenerApi(flutterPluginBinding.binaryMessenger).emitSimInformation(it) {
        // We don't care about the reply callback
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    HostApi.HostInitiatedApi.setup(binding.binaryMessenger, null)
    subscriptionChangeStreamHandler.destroy()
  }

  override fun addSimSubscriptionChangeHandler() {
    subscriptionChangeStreamHandler.startListeningSimSubscriptionChanges()
  }

  override fun removeSimSubscriptionChangeHandler() {
    subscriptionChangeStreamHandler.stopListeningSimSubscriptionChanges()
  }
}
