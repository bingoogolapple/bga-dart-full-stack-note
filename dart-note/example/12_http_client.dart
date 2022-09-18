import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

main() async {
  test5();
}

test5() async {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8888/',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    // 默认会将请求体转换为 json 对象（Map），不用再手动 json.encode
    contentType: Headers.jsonContentType,
    // 默认会将响应体转换为 json 对象（Map），不用再手动 json.decode
    responseType: ResponseType.json,
  ));

  Dio tokenDio = Dio();
  tokenDio.options = dio.options;
  String csrfToken;

  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    print('\nInterceptor onRequest => ${options.uri.toString()}');

//    return dio.resolve('自定义数据，改变请求执行流');
//    return dio.reject('终止请求');

    if (csrfToken == null) {
      print('token 不存在，先获取 token');
      dio.interceptors.requestLock.lock();
      return tokenDio.get("token").then((response) {
        options.headers["csrfToken"] = csrfToken = response.data['data'];
        print("请求 token 成功:$csrfToken");
        return options;
      }).catchError((e) {
        print(e.toString());
      }).whenComplete(() {
        dio.interceptors.requestLock.unlock();
      });
    } else {
      options.headers["csrfToken"] = csrfToken;
      return options;
    }
  }, onResponse: (Response response) async {
    print('Interceptor onResponse =>  ${response.request.uri.toString()}\n');

//    return dio.resolve('自定义数据，改变请求执行流');
//    return dio.reject('终止请求');
    return response;
  }, onError: (DioError error) async {
    print('Interceptor onError => $error');

    if (error.response?.statusCode == 401) {
      RequestOptions options = error.response.request;
      if (csrfToken != options.headers["csrfToken"]) {
        options.headers["csrfToken"] = csrfToken;
        // 重试
        return dio.request(options.path, options: options);
      }
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();
      dio.interceptors.errorLock.lock();
      return tokenDio.get("token").then((response) {
        options.headers["csrfToken"] = csrfToken = response.data['data'];
      }).whenComplete(() {
        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();
        dio.interceptors.errorLock.unlock();
      }).then((e) {
        // 重试
        return dio.request(options.path, options: options);
      });
    }
    return error;
  }));
  dio.interceptors.add(LogInterceptor(responseBody: false));

  dio.get('blogs').then((response) {
    print(response.data.toString());
    return dio.delete('blogs/1');
  }).then((response) {
    print(response.data.toString());
    return dio.post('blogs', data: {'title': '我是新增博客的标题', 'content': '我是新增博客的内容'});
  }).then((response) {
    print(response.data.toString());
    return dio.put('blogs/2', data: {'id': 2, 'title': '我是修改后博客的标题', 'content': '我是修改后博客的内容'});
  }).then((response) {
    print(response.data.toString());
    return dio.get('blogs/2');
  }).then((response) {
    print(response.data.toString());
    return dio.get('blogs');
  }).then((response) {
    print(response.data.toString());
  }).catchError((e) {
    print('请求失败 $e');
  }).whenComplete(() {
    // 完成后关闭 dio 连接
    dio.close();
  });
}

test4() {
  var url = 'http://localhost:8888/';
  // Client 类，保持持久连接，向同一个服务器发多个请求
  var client = new http.Client();
  client.get('${url}blogs').timeout(Duration(seconds: 3)).then((response) {
    print(response.body);
    return client.delete('${url}blogs/1');
  }).then((response) {
    print(response.body);
    return client.post('${url}blogs', body: json.encode({'title': '我是新增博客的标题', 'content': '我是新增博客的内容'}));
  }).then((response) {
    print(response.body);
    return client.put('${url}blogs/2', body: json.encode({'id': 2, 'title': '我是修改后博客的标题', 'content': '我是修改后博客的内容'}));
  }).then((response) {
    print(response.body);
    return client.get('${url}blogs/2');
  }).then((response) {
    print(response.body);
    return client.get('${url}blogs');
  }).then((response) {
    print(response.body);
  }).catchError((e) {
    print(e);
  }).whenComplete(() {
    // 完成后关闭 Client 连接
    client.close();
  });
}

test3() {
  var url = 'http://localhost:8888/blogs';
  http.post(url, body: json.encode({'title': '我是新增博客的标题', 'content': '我是新增博客的内容'})).then((response) {
    print("响应状态：${response.statusCode}");
    print("响应正文：${response.body}");
  });
}

test2() {
  var url = 'http://localhost:8888/blogs';
  http.get(url).then((response) {
    print("响应状态：${response.statusCode}");
    print("响应正文：${response.body}");
  });
}

test1() async {
  var url = Uri.parse('http://localhost:8888/blogs');
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(url);
  print('have request');
  var response = await request.close();
  print('have response');
  var body = await utf8.decoder.bind(response).first;
  print(body);
  httpClient.close();
}
