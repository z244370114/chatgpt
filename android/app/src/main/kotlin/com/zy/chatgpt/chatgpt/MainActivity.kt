package com.zy.chatgpt.chatgpt

import android.os.Bundle
import com.umeng.commonsdk.UMConfigure.preInit
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        preInit(this, "649e6457a1a164591b3e7ed7", "xiaomi")
    }
}
