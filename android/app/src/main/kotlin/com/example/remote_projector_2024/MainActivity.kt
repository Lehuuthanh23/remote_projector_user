package com.example.remote_projector_2024

import com.example.remote_projector_2024.plugin.InstallPlugin
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant.registerWith

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(InstallPlugin())

        registerWith(flutterEngine)
    }
}
