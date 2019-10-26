package cn.bingoogolapple.hybrid_android

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.gson.Gson
import io.flutter.facade.Flutter
import kotlinx.android.synthetic.main.activity_android_use_flutter_two_mode.*

class AndroidUseFlutterTwoModeActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_android_use_flutter_two_mode)
        flutter_create_view.setOnClickListener {
            val routeMap = Gson().toJson(mapOf("path" to "flutter_create_view", "arguments" to "Android 通过 Flutter.createView 集成 Flutter"))
            val flutterView = Flutter.createView(this, lifecycle, routeMap)
            flutter_view_container.addView(flutterView)
        }
        flutter_create_fragment.setOnClickListener {
            val routeMap = Gson().toJson(mapOf("path" to "flutter_create_fragment", "arguments" to "Android 通过 Flutter.createFragment 集成 Flutter"))
            supportFragmentManager.beginTransaction()
                .replace(R.id.flutter_fragment_container, Flutter.createFragment(routeMap))
                .commit()
        }
    }
}
