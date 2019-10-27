package cn.bingoogolapple.hybrid_android

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.gson.Gson
import io.flutter.facade.Flutter
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.android.synthetic.main.activity_event_channel.flutter_container
import kotlinx.android.synthetic.main.activity_method_channel.*
import kotlin.random.Random

class MethodChannelActivity : AppCompatActivity(), MethodChannel.MethodCallHandler {
    private var channel: MethodChannel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_method_channel)
        title = "MethodChannelDemo"

        val routeMap = Gson().toJson(mapOf("path" to "method_channel_demo"))
        val flutterView = Flutter.createView(this, lifecycle, routeMap)
        channel = MethodChannel(flutterView, "MethodChannelPlugin")
        channel!!.setMethodCallHandler(this)
        flutter_container.addView(flutterView)

        invoke_method_without_result.setOnClickListener {
            channel!!.invokeMethod("nativeInvokeFlutterWithoutResult", "red")
        }
        invoke_method_with_result.setOnClickListener {
            channel!!.invokeMethod("nativeInvokeFlutterWithResult", 100, object : Result {
                override fun success(result: Any?) {
                    appendLog("${Thread.currentThread().name} Android 收到执行成功结果：$result")
                }

                override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                    appendLog("${Thread.currentThread().name} Android 收到执行失败结果：$errorCode | $errorMessage | $errorDetails")
                }

                override fun notImplemented() {
                    appendLog("${Thread.currentThread().name} Android 收到 notImplemented")
                }
            })
        }
    }

    private fun appendLog(msg: String) {
        log_panel.text = "${log_panel.text}\n$msg"
    }

    override fun onMethodCall(methodCall: MethodCall, result: Result) {
        appendLog("----------\n${Thread.currentThread().name} 收到 Flutter 调用：${methodCall.method}")
        if (methodCall.method == "flutterInvokeNativeWithoutResult") {
            appendLog("Android 收到 flutterInvokeNativeWithoutResult：${methodCall.method} | ${methodCall.arguments}")
        } else if (methodCall.method == "flutterInvokeNativeWithResult") {
            appendLog("Android 收到 flutterInvokeNativeWithResult：${methodCall.method} | ${methodCall.arguments}")
            // 给 Flutter 端的返回值
            if (Random.nextBoolean()) {
                result.success("Android 收到 flutterInvokeNativeWithResult")
            } else {
                result.error(
                    "我是错误码",
                    "我是错误消息",
                    Gson().toJson(mapOf("key1" to "value1", "key2" to "value2"))
                )
            }
        } else {
            result.notImplemented()
        }
    }

}
