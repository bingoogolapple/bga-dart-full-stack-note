# hybrid_flutter

https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps

1、创建 flutter module

```bash
flutter create -t module --org=cn.bingoogolapple hybrid_flutter
```

## Flutter 与 Android 混合开发

### 通过 aar 方式引入

1、构建 aar

```bash
# release
flutter build aar
# debug
flutter build aar --debug
```
2、添加私服
```groovy
repositories {
  maven {
    url '../../hybrid_flutter/build/host/outputs/repo'
  }
}
```
3、添加 aar 依赖
```groovy
releaseCompile ('cn.bingoogolapple.hybrid_flutter:flutter_release:1.0@aar') {
  transitive = true
}
releaseCompile ('cn.bingoogolapple.hybrid_flutter:flutter_debug:1.0@aar') {
  transitive = true
}
```

### 通过 module 依赖引入

1、在 settings.gradle 文件中添加如下代码

```groovy
setBinding(new Binding([gradle:this]))
evaluate(new File(settingsDir.parentFile,'hybrid_flutter/.android/include_flutter.groovy'))
```
2、同步 gradle 后就能看到在原生 Android 工程中中多个名叫「Flutter」的 module

3、在 Android 原生工程的 module/build.gradle 中添加依赖

```groovy
implementation project(':flutter')
```

4、配置 Android 原生工程的 module/build.gradle，使其支持 Java8

```groovy
android {
    compileOptions {
        sourceCompatibility 1.8
        targetCompatibility 1.8
    }
}
```
5、通过 Flutter.createView 来使用过 Flutter

```kotlin
val routeMap = Gson().toJson(mapOf("path" to "flutter_create_view", "arguments" to "Android 通过 Flutter.createView 集成 Flutter"))
val flutterView = Flutter.createView(this, lifecycle, routeMap)
flutter_view_container.addView(flutterView)
```
6、通过 Flutter.createFragment 来使用过 Flutter

```kotlin
val routeMap = Gson().toJson(mapOf("path" to "flutter_create_fragment", "arguments" to "Android 通过 Flutter.createFragment 集成 Flutter"))
supportFragmentManager.beginTransaction()
    .replace(R.id.flutter_fragment_container, Flutter.createFragment(routeMap))
    .commit()
```

## Flutter 与 iOS 混合开发

https://github.com/flutter/flutter/wiki/Upgrading-Flutter-added-to-existing-iOS-Xcode-project

1、安装 cocoapods

```bash
sudo gem install cocoapods
```
2、初始化 Podfile

```bash
pod init
```
3、在 Podfile 中添加 Flutter 依赖

```
flutter_application_path = "../hybrid_flutter"
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'hybrid_ios' do
  install_all_flutter_pods(flutter_application_path)
end
```

4、老版本需要在「Build phase」中配置下面的代码，「Flutter 1.8.4-pre.21」之后不需要再配置下面的脚本，而且必须删除

```groovy
"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" build
"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" embed
```

5、重新生成「podhelper.rb」

```bash
rm .ios/Flutter/podhelper.rb
flutter build ios
```
6、安装 Flutter 依赖

```bash
pod install
```

7、关闭现有的 hybrid_ios.xcodeproj，打开 hybrid_ios.xcworkspace

8、如果后续再 pubspec.yaml 添加了 Flutter 插件，出来需要在 hybrid_flutter 目录下运行 flutter packages get 外，还要再 hybrid_ios 目录下执行 pod install 来刷新 podhelper.rb

9、禁用 Bitcode

```
Build Settings -> Build Options -> Enable Bitcode 设置为 No
```