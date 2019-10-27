package cn.bingoogolapple.hybrid_android

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.gson.Gson
import io.flutter.facade.Flutter
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec
import kotlinx.android.synthetic.main.activity_basic_message_channel.*
import kotlinx.android.synthetic.main.activity_event_channel.flutter_container
import kotlinx.android.synthetic.main.activity_method_channel.*
import kotlinx.android.synthetic.main.activity_method_channel.log_panel

class BasicMessageChannelActivity : AppCompatActivity(),
    BasicMessageChannel.MessageHandler<String> {
    private var channel: BasicMessageChannel<String>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_basic_message_channel)
        title = "BasicMessageChannelDemo"

        val routeMap = Gson().toJson(mapOf("path" to "basic_message_channel_demo"))
        val flutterView = Flutter.createView(this, lifecycle, routeMap)
        channel = BasicMessageChannel<String>(
            flutterView,
            "BasicMessageChannelPlugin",
            StringCodec.INSTANCE
        )
        channel!!.setMessageHandler(this)
        flutter_container.addView(flutterView)

        send_message_without_result.setOnClickListener {
            channel!!.send("Android 发送消息，without result")
        }
        send_message_with_result.setOnClickListener {
            channel!!.send("Android 发送消息，with result") { result ->
                appendLog("${Thread.currentThread().name} Android 收到结果：$result")
            }
        }
    }

    override fun onMessage(message: String?, reply: BasicMessageChannel.Reply<String>) {
        appendLog("${Thread.currentThread().name} Android 收到消息 $message")
        message?.let {
            if (it.contains("with result")) {
                reply.reply("Android 收到消息 $message 后回复")
            }
        }
    }

    private fun appendLog(msg: String) {
        log_panel.text = "${log_panel.text}\n$msg"
    }
}
