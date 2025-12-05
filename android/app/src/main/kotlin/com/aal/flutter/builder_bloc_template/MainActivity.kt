package com.aal.flutter.builder_bloc_template

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "com.aal.flutter.builder_bloc_template/custom_view",
                MyNativeViewFactory()
            )
  }
}
