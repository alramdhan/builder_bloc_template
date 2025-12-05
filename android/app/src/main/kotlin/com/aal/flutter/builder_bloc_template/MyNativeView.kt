package com.aal.flutter.builder_bloc_template

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

class MyNativeView(context: Context, id: Int): PlatformView {
    private val textView: TextView = TextView(context)

    init {
        textView.textSize = 24f
        textView.setBackgroundColor(Color.LTGRAY)
        textView.text = "Ini dari native"
    }

    override fun getView(): View {
        return textView
    }

    override fun dispose() {

    }
}