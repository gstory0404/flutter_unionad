package com.gstory.flutter_unionad_example

import androidx.annotation.NonNull
import com.gstory.flutter_unionad.FlutterUnionadEventPlugin
import com.gstory.flutter_unionad.FlutterUnionadPlugin
import com.gstory.flutter_unionad.FlutterUnionadViewPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(FlutterUnionadEventPlugin())
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        FlutterUnionadViewPlugin.registerWith(flutterEngine)
        FlutterUnionadPlugin.setAcitivyt(this)
    }
}
