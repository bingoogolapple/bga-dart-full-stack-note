// 配置 Web 应用的 URL 策略 https://flutter.cn/docs/development/ui/navigation/url-strategies
export 'package:flutter_app/platform/url_strategy/url_strategy_noop.dart'
    if (dart.library.html) 'package:flutter_app/platform/url_strategy/url_strategy_web.dart';
