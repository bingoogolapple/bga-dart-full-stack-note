import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HttpClientWidget extends StatefulWidget {
  @override
  _HttpClientWidgetState createState() => _HttpClientWidgetState();
}

class _HttpClientWidgetState extends State<HttpClientWidget> {
  StringBuffer _logSb = StringBuffer();
  Dio? _dio;
  String? _csrfToken;

  @override
  void initState() {
    super.initState();
    _initDio();
  }

  @override
  void dispose() {
    _closeDio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          color: Colors.green,
          child: Text('多个请求'),
          onPressed: () {
            _multipleRequest();
          },
        ),
        MaterialButton(
          color: Colors.green,
          child: Text('单个请求'),
          onPressed: () {
            _singleRequest();
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: Text('清空 Token'),
          onPressed: () {
            _csrfToken = null;
          },
        ),
        MaterialButton(
          color: Colors.orange,
          child: Text('清空日志'),
          onPressed: () {
            setState(() {
              _logSb.clear();
            });
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(_logSb.toString()),
            ),
          ),
        ),
      ],
    );
  }

  _initDio() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:8888/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      // 默认会将请求体转换为 json 对象（Map），不用再手动 json.encode
      contentType: Headers.jsonContentType,
      // 默认会将响应体转换为 json 对象（Map），不用再手动 json.decode
      responseType: ResponseType.json,
    ));

    Dio tokenDio = Dio();
    tokenDio.options = _dio!.options;

    _dio?.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      appendLog('\nInterceptor onRequest => ${options.uri.toString()}');

//    return _dio.resolve('自定义数据，改变请求执行流');
//    return _dio.reject('终止请求');

      if (_csrfToken == null) {
        appendLog('token 不存在，先获取 token');
        // _dio?.interceptors.requestLock.lock();
        // return tokenDio.get("token").then((response) {
        //   options.headers["csrfToken"] = _csrfToken = response.data['data'];
        //   appendLog("请求 token 成功:$_csrfToken");
        //   return options;
        // }).catchError((e) {
        //   appendLog('获取token失败：$e');
        // }).whenComplete(() {
        //   _dio.interceptors.requestLock.unlock();
        // });
      } else {
        options.headers["csrfToken"] = _csrfToken;
        // return options;
      }
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      appendLog(
          'Interceptor onResponse =>  ${response.requestOptions.uri.toString()}\n');

//    return _dio.resolve('自定义数据，改变请求执行流');
//    return _dio.reject('终止请求');
      handler.resolve(response);
    }, onError: (DioError error, ErrorInterceptorHandler handler) {
      appendLog('Interceptor onError => $error');

      if (error.response?.statusCode == 401) {
        RequestOptions options = error.requestOptions;
        if (_csrfToken != options.headers["csrfToken"]) {
          options.headers["csrfToken"] = _csrfToken;
          // 重试
          // return _dio.request(options.path, options: options);
        }
        // _dio?.interceptors.requestLock.lock();
        // _dio?.interceptors.responseLock.lock();
        // _dio?.interceptors.errorLock.lock();
        // return tokenDio.get("token").then((response) {
        //   options.headers["csrfToken"] = _csrfToken = response.data['data'];
        // }).whenComplete(() {
        //   _dio?.interceptors.requestLock.unlock();
        //   _dio?.interceptors.responseLock.unlock();
        //   _dio?.interceptors.errorLock.unlock();
        // }).then((e) {
        //   // 重试
        //   return _dio?.request(options.path, options: options);
        // });
      }
      // return error;
    }));
    _dio?.interceptors.add(LogInterceptor(responseBody: false));
  }

  _closeDio() {
    // 完成后关闭 _dio 连接
    _dio?.close();
  }

  _singleRequest() async {
    _dio?.get('blogs').then((response) {
      appendLog(response.data.toString());
    }).catchError((e) {
      appendLog('请求失败 $e');
    }).whenComplete(() {
      appendLog('请求结束');
    });
  }

  _multipleRequest() async {
    _dio?.get('blogs').then((response) async {
      appendLog(response.data.toString());
      return _dio?.delete('blogs/1');
    }).then((response) async {
      appendLog(response?.data.toString());
      return _dio
          ?.post('blogs', data: {'title': '我是新增博客的标题', 'content': '我是新增博客的内容'});
    }).then((response) async {
      appendLog(response?.data.toString());
      return _dio?.put('blogs/2',
          data: {'id': 2, 'title': '我是修改后博客的标题', 'content': '我是修改后博客的内容'});
    }).then((response) async {
      appendLog(response?.data.toString());
      return _dio?.get('blogs/2');
    }).then((response) async {
      appendLog(response?.data.toString());
      return _dio?.get('blogs');
    }).then((response) {
      appendLog(response?.data.toString());
    }).catchError((e) {
      appendLog('请求失败 $e');
    }).whenComplete(() {
      appendLog('请求结束');
    });
  }

  appendLog(msg) {
    setState(() {
      _logSb.writeln(msg);
    });
  }
}
