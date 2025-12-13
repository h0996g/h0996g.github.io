package com.example.noor

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class OverlayPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var context: Context? = null
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "overlay_notification")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "showOverlay" -> {
                val adkarText = call.argument<String>("adkar_text") ?: ""
                val textSize = call.argument<Double>("text_size")?.toFloat() ?: 18f
                val textColor = (call.argument<Any>("text_color") as? Number)?.toInt() ?: android.graphics.Color.BLACK
                val backgroundColor = (call.argument<Any>("background_color") as? Number)?.toInt() ?: android.graphics.Color.WHITE

                showOverlay(adkarText, textSize, textColor, backgroundColor)
                result.success(true)
            }
            "startScheduler" -> {
                val intervalMinutes = call.argument<Int>("interval_minutes") ?: 15
                startScheduler(intervalMinutes)
                result.success(true)
            }
            "stopScheduler" -> {
                stopScheduler()
                result.success(true)
            }
            "checkPermission" -> {
                val hasPermission = checkOverlayPermission()
                result.success(hasPermission)
            }
            "requestPermission" -> {
                requestOverlayPermission()
                result.success(true)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun showOverlay(adkarText: String, textSize: Float, textColor: Int, backgroundColor: Int) {
        context?.let { ctx ->
            val intent = Intent(ctx, OverlayNotificationService::class.java).apply {
                putExtra("adkar_text", adkarText)
                putExtra("text_size", textSize)
                putExtra("text_color", textColor)
                putExtra("background_color", backgroundColor)
            }
            ctx.startService(intent)
        }
    }

    private fun startScheduler(intervalMinutes: Int) {
        context?.let { ctx ->
            val intent = Intent(ctx, OverlayNotificationService::class.java).apply {
                action = OverlayNotificationService.ACTION_START_LOOP
                putExtra("interval_input", intervalMinutes * 60 * 1000L)
            }
            
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                ctx.startForegroundService(intent)
            } else {
                ctx.startService(intent)
            }
        }
    }

    private fun stopScheduler() {
        context?.let { ctx ->
            val intent = Intent(ctx, OverlayNotificationService::class.java)
            ctx.stopService(intent)
        }
    }

    private fun checkOverlayPermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Settings.canDrawOverlays(context)
        } else {
            true
        }
    }

    private fun requestOverlayPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            activity?.let { act ->
                val intent = Intent(
                    Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                    Uri.parse("package:${context?.packageName}")
                )
                act.startActivity(intent)
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
