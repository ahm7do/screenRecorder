package com.example.animation_app

import android.os.Bundle
import com.prongbang.screenprotect.AndroidScreenProtector
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    private val screenProtector by lazy { AndroidScreenProtector.newInstance(this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Other Flutter initialization if required
    }

    override fun onPause() {
        super.onPause()
        screenProtector.protect()  // Protect the screen when the app is paused
    }

    override fun onResume() {
        super.onResume()
        screenProtector.unprotect()  // Unprotect the screen when the app is resumed
    }

    // For Android 12+
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        screenProtector.process(!hasFocus)  // Manage screen protection based on focus
    }
}
