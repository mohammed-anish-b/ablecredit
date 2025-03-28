package com.example.ablecredit

import android.content.Intent
import android.Manifest
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "foreground_service"
    private val FOREGROUND_PERMISSION = Manifest.permission.FOREGROUND_SERVICE_DATA_SYNC
    private val PERMISSION_REQUEST_CODE = 101

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startService" -> {
                        startForegroundService()
                        result.success("Service Started")
                    }

                    "stopService" -> {
                        stopForegroundService()
                        result.success("Service Stopped")
                    }

                    else -> result.notImplemented()
                }
            }
    }

    private fun startForegroundService() {
        requestForegroundServicePermission()
        val serviceIntent = Intent(this, ForegroundService::class.java)
        startService(serviceIntent)
    }

    private fun stopForegroundService() {
        val serviceIntent = Intent(this, ForegroundService::class.java)
        stopService(serviceIntent)
    }

    private fun requestForegroundServicePermission() {
        if (ContextCompat.checkSelfPermission(
                this,
                FOREGROUND_PERMISSION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(FOREGROUND_PERMISSION),
                PERMISSION_REQUEST_CODE
            )
        }
    }
}
