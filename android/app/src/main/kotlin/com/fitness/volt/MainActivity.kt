package com.fitness.volt

import android.os.Bundle
import android.os.PersistableBundle
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;



class MainActivity: FlutterActivity(), PluginRegistrantCallback {
    private val CHANNEL ="flutter.native/helper";


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            result.success("Native code run");
        }
    }


    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }


    override fun registerWith(register: PluginRegistry) {

//        GeneratedPluginRegistrant.registerWith(registry as FlutterEngine);
        FirebaseMessagingPlugin.registerWith(register?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
//        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
    }


}
