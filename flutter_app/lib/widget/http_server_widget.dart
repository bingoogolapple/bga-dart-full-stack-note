import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

class HttpServerWidget extends StatefulWidget {
  const HttpServerWidget({super.key});

  @override
  State<HttpServerWidget> createState() => _HttpServerWidgetState();
}

class _HttpServerWidgetState extends State<HttpServerWidget> {
  final Map _blogMap = <String, Map<String, dynamic>>{};
  final StringBuffer _logSb = StringBuffer();
  int _currentMaxId = 1;

  HttpServer? _httpServer;
  late shelf.Handler _handler;

  @override
  void initState() {
    super.initState();
    _initDefaultBlogList();
    _initHandler();
  }

  @override
  void dispose() {
    _stopServer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        MaterialButton(
          color: Colors.green,
          child: const Text('启动服务'),
          onPressed: () {
            _startServer();
          },
        ),
        const SizedBox(height: 8),
        MaterialButton(
          color: Colors.grey,
          child: const Text('停止服务'),
          onPressed: () {
            _stopServer();
          },
        ),
        const SizedBox(height: 8),
        MaterialButton(
          color: Colors.orange,
          child: const Text('清空日志'),
          onPressed: () {
            setState(() {
              _logSb.clear();
            });
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(_logSb.toString()),
            ),
          ),
        ),
      ],
    );
  }

  _initDefaultBlogList() {
    _blogMap['$_currentMaxId'] = {
      'id': _currentMaxId,
      'title': '标题$_currentMaxId',
      'content': '内容$_currentMaxId'
    };
    _currentMaxId++;
    _blogMap['$_currentMaxId'] = {
      'id': _currentMaxId,
      'title': '标题$_currentMaxId',
      'content': '内容$_currentMaxId'
    };
  }

  _initHandler() {
    shelf_router.Router router = shelf_router.Router();
    _initAuthHandler(router);
    _initBlogHandler(router);
    _handler = const shelf.Pipeline()
        .addMiddleware(shelf.logRequests())
        .addHandler(router);
  }

  _initAuthHandler(shelf_router.Router router) {
    router.get('/token', (shelf.Request request) {
      appendLog('请求了 get /token');
      return responseJson({'code': 0, 'msg': '获取token成功', 'data': 'TODO'});
    });
  }

  _initBlogHandler(shelf_router.Router router) {
    router
      ..get('/blogs', (shelf.Request request) {
        appendLog('请求了 get /blogs');
        return responseJson(
            {'code': 0, 'msg': '获取博客列表成功', 'data': _blogMap.values.toList()});
      })
      ..post('/blogs', (shelf.Request request) {
        appendLog('请求了 post /blogs');
        return request.readAsString().then((body) {
          appendLog('新增博客：\n$body');
          final blog = json.decode(body);
          blog['id'] = ++_currentMaxId;
          _blogMap['$_currentMaxId'] = blog;
          return responseJson({'code': 0, 'msg': '创建成功'});
        }).catchError((e) {
          appendLog('创建博客失败：$e');
          return responseJson({'code': 1, 'msg': '创建失败'});
        });
      })
      ..put('/blogs/<blogId>', (shelf.Request request, String blogId) async {
        appendLog('请求了 put /blogs/$blogId');
        try {
          final body = await request.readAsString();
          if (_blogMap.containsKey(blogId)) {
            final blog = json.decode(body);
            blog['id'] = blogId;
            _blogMap[blogId] = blog;
            return responseJson({'code': 0, 'msg': '更新$blogId成功'});
          } else {
            return responseJson({'code': 1, 'msg': '更新失败，不存在id为$blogId的博客'});
          }
        } catch (e) {
          appendLog('更新博客失败：$e');
          return responseJson({'code': 1, 'msg': '更新失败'});
        }
      })
      ..delete('/blogs/<blogId>', (shelf.Request request, String blogId) {
        _blogMap.remove(blogId);
        appendLog('请求了 remove /blogs/$blogId');
        return responseJson({'code': 0, 'msg': '删除$blogId成功'});
      })
      ..get('/blogs/<blogId>', (shelf.Request request, String blogId) {
        appendLog('请求了 get /blogs/$blogId');
        if (_blogMap.containsKey(blogId)) {
          return responseJson(
              {'code': 0, 'msg': '获取博客成功', 'data': _blogMap[blogId]});
        } else {
          return responseJson({'code': 1, 'msg': '不存在id为$blogId的博客'});
        }
      });
  }

  _startServer() async {
    if (_httpServer != null) {
      return;
    }
    shelf_io
        .serve(_handler, InternetAddress.loopbackIPv4, 8888)
        .then((httpServer) {
      _httpServer = httpServer;
      appendLog('启动服务成功：${_httpServer?.port}');
    }).catchError((e) {
      appendLog('启动服务失败：$e');
    });
  }

  _stopServer() {
    _httpServer?.close(force: true).then((serverSocket) {
      appendLog('停止服务成功：$serverSocket');
      _httpServer = null;
    }).catchError((e) {
      appendLog('停止服务异常：$e');
    });
  }

  responseJson(Map body) {
//  sleep(Duration(seconds: 4));
    return shelf.Response.ok(json.encode(body),
        headers: {'content-type': 'application/json; charset=utf-8'});
  }

  appendLog(msg) {
    setState(() {
      _logSb.writeln(msg);
    });
  }
}
