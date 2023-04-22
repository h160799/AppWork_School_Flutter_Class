package com.example.flutter_programe_johnny

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.flutter_programe_johnny"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
      // This method is invoked on the main thread.
      call, result ->
      if (call.method == "callAndroid") {
        // 處理 callAndroid 方法的請求
            val response = "Hello from Android"
            result.success(response)
        } else {
        result.notImplemented()
      }
    }
  }
}