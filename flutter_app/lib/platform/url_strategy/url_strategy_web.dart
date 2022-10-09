import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void setPathUrlStrategy() {
  setUrlStrategy(PathUrlStrategy());
}

void setHashUrlStrategy() {
  setUrlStrategy(const HashUrlStrategy());
}
