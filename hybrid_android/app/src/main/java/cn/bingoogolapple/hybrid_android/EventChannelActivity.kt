package cn.bingoogolapple.hybrid_android

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.gson.Gson
import io.flutter.Log
import io.flutter.facade.Flutter
import io.flutter.plugin.common.EventChannel
import kotlinx.android.synthetic.main.activity_event_channel.*

class EventChannelActivity : AppCompatActivity(), EventChannel.StreamHandler {
    private val TAG = EventChannelActivity::class.java.simpleName
    private var mEventSink: EventChannel.EventSink? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_event_channel)
        title = "EventChannelDemo"

        val routeMap = Gson().toJson(mapOf("path" to "event_channel_demo"))
        val flutterView = Flutter.createView(this, lifecycle, routeMap)
        EventChannel(flutterView, "EventChannelPlugin").setStreamHandler(this)
        flutter_container.addView(flutterView)

        send_data.setOnClickListener {
            if (mEventSink != null) {
                mEventSink!!.success("Android 发送 success")
            }
        }
        send_error.setOnClickListener {
            if (mEventSink != null) {
                mEventSink!!.error(
                    "errorCode",
                    "Android 发送 error",
                    Gson().toJson(mapOf("key1" to "value1", "key2" to "value2"))
                )
//                mEventSink!!.endOfStream()
            }
        }
        send_done.setOnClickListener {
            if (mEventSink != null) {
                mEventSink!!.endOfStream()
            }
        }
    }

    // onCancel 和 onListen 的第一个参数都是 flutter 初始化 EventChannel 时返回的值，可能为空
    override fun onListen(arguments: Any, eventSink: EventChannel.EventSink) {
        mEventSink = eventSink
        Log.i(TAG, "${Thread.currentThread().name} onListen arguments：$arguments")
        Log.i(TAG, "onListen eventSink：$eventSink")
    }

    override fun onCancel(arguments: Any) {
        Log.i(TAG, "${Thread.currentThread().name} onCancel：$arguments")
        mEventSink = null
    }
}
