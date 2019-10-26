package cn.bingoogolapple.hybrid_android

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        android_use_flutter_two_mode.setOnClickListener {
            startActivity(Intent(this, AndroidUseFlutterTwoModeActivity::class.java))
        }
    }
}
