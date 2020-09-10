package com.gstory.flutter_unionad

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/19 18:52
 */
class FlutterUnionadEventPlugin : FlutterPlugin, EventChannel.StreamHandler {
    private var channelName = "com.gstory.flutter_unionad/adevent";

    companion object {
        private var eventChannel: EventChannel? = null

        private var eventSink: EventChannel.EventSink? = null

        private var context: Context? = null

        fun sendContent(content:Map<String,Any>) {
            eventSink?.success(content);
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        eventChannel = EventChannel(binding.binaryMessenger, channelName)
        eventChannel!!.setStreamHandler(this)
        context = binding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        eventChannel = null
        eventChannel!!.setStreamHandler(null)
    }
}