import 'dart:async';

class EventBus {
  // 保存单例
  static EventBus? _instance;

  // 工厂构造函数
  factory EventBus({bool sync = false, StreamController? controller}) =>
      _getInstance(sync: sync, controller: controller);

  // 私有构造函数
  EventBus._({bool sync = false, StreamController? controller}) {
    if (controller != null) {
      _streamController = controller;
      return;
    }
    _streamController = StreamController.broadcast(sync: sync);
  }

  static EventBus _getInstance(
      {bool sync = false, StreamController? controller}) {
    _instance ??= EventBus._(sync: sync, controller: controller);
    return _instance!;
  }

  late StreamController _streamController;

  StreamController get streamController => _streamController;

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  void emit(event) {
    streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}
