// test1、test2
import 'dart:convert';
import 'dart:io';
import 'dart:convert' show json;

// test3
import 'package:shelf_static/shelf_static.dart' as shelf_static;

// test4
import 'package:http_server/http_server.dart';

// test5
import 'package:http_multi_server/http_multi_server.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

// test6
import 'package:shelf_router/shelf_router.dart';

main() async {
  test3();
}

test1() async {
  var requests = await HttpServer.bind('127.0.0.1', 8888);
  await for (var request in requests) {
    dispatchRequest(request);
  }
}

test2() {
  HttpServer.bind(InternetAddress.loopbackIPv4, 8888).then((server) {
    print("Serving at ${server.address}:${server.port}");
    server.listen((HttpRequest request) {
      dispatchRequest(request);
    });
  });
}

// 静态文件服务器
test3() async {
  var staticHandler = shelf_static.createStaticHandler(Platform.script.resolve('web').toFilePath(), defaultDocument: 'index.html', listDirectories: true);

//  var server = await shelf_io.serve(staticHandler, InternetAddress.loopbackIPv4, 8888);
  final handler = shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(staticHandler);
  var server = await shelf_io.serve(handler, InternetAddress.loopbackIPv4, 8888);
  print('Server running on localhost:${server.port}');
}

// 静态文件服务器
test4() async {
  var virDir;
  virDir = new VirtualDirectory(Platform.script.resolve('web').toFilePath())
    ..allowDirectoryListing = true // 是否获取目录清单，为 false 则不获取
    ..errorPageHandler = (HttpRequest request) {
      // 覆盖默认的错误处理页面，要注意顺序（错误处理要放在正常处理前面，否则无效）
      request.response
        ..statusCode = HttpStatus.notFound // 设置状态码，如果没有设置则默认 HttpStatus.OK
        ..write('Not found')
        ..close();
    }
    ..directoryHandler = (dir, request) {
      if (request.uri.path == '/') {
        // 用指定的文件覆盖默认返回的目录清单
        var indexUri = new Uri.file(dir.path).resolve('index.html'); // 获取文件的路径
        virDir.serveFile(new File(indexUri.toFilePath()), request); // 返回指定的文件
      }
    };

  HttpServer.bind(InternetAddress.loopbackIPv4, 8888).then((server) {
    server.listen((request) {
      // 将文件和目录清单发送到客户端
      virDir.serveRequest(request);
    });
  });
}

test5() async {
  // Both http://127.0.0.1:8888 and http://[::1]:8888 will be bound to the same server.
  var server = await HttpMultiServer.loopback(8888);
  shelf_io.serveRequests(server, (request) {
    return shelf.Response.ok("Hello, world!");
  });
}

test6() async {
  var currentMaxId = 1;
  final BLOG_REPO = Map<String,Map<String, dynamic>>();
  BLOG_REPO['$currentMaxId'] = {'id': currentMaxId, 'title': '标题$currentMaxId', 'content': '内容$currentMaxId'};
  currentMaxId++;
  BLOG_REPO['$currentMaxId'] = {'id': currentMaxId, 'title': '标题$currentMaxId', 'content': '内容$currentMaxId'};

  var app = Router()
    ..get('/token', (shelf.Request request) {
      return responseJson({'code': 0, 'msg': '获取token成功', 'data': 'TODO'});
    })
    ..get('/blogs', (shelf.Request request) {
      return responseJson({'code': 0, 'msg': '获取博客列表成功', 'data': BLOG_REPO.values.toList()});
    })
    ..post('/blogs', (shelf.Request request) {
      return request.readAsString().then((body) {
        print('新增博客：\n$body');
        final blog = json.decode(body);
        blog['id'] = ++currentMaxId;
        BLOG_REPO['$currentMaxId'] = blog;
        return responseJson({'code': 0, 'msg': '创建成功'});
      }).catchError((e) {
        print(e);
        return responseJson({'code': 1, 'msg': '创建失败'});
      });
    })
    ..put('/blogs/<blogId>', (shelf.Request request, String blogId) async {
      try {
        final body = await request.readAsString();
        if (BLOG_REPO.containsKey('$blogId')) {
          final blog = json.decode(body);
          blog['id'] = blogId;
          BLOG_REPO['$blogId'] = blog;
          return responseJson({
            'code': 0,
            'msg': '更新$blogId成功'
          });
        } else {
          return responseJson({
            'code': 1,
            'msg': '更新失败，不存在id为$blogId的博客'
          });
        }
      } catch (e) {
        print(e);
        return responseJson({'code': 1, 'msg': '更新失败'});
      }
    })
    ..delete('/blogs/<blogId>', (shelf.Request request, String blogId) {
      BLOG_REPO.remove('$blogId');
      return responseJson({'code': 0, 'msg': '删除$blogId成功'});
    })
    ..get('/blogs/<blogId>', (shelf.Request request, String blogId) {
      if (BLOG_REPO.containsKey('$blogId')) {
        return responseJson({
          'code': 0,
          'msg': '获取博客成功',
          'data': BLOG_REPO['$blogId']
        });
      } else {
        return responseJson({
          'code': 1,
          'msg': '不存在id为$blogId的博客'
        });
      }
    });
  final handler = shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(app.handler);
  var server = await shelf_io.serve(handler, InternetAddress.loopbackIPv4, 8888);
  print(server.runtimeType); // _HttpServer
  print('Server running on localhost:${server.port}');
}

responseJson(Map body) {
//  sleep(Duration(seconds: 4));
  return shelf.Response.ok(json.encode(body), headers: {'content-type': 'application/json; charset=utf-8'});
}

dispatchRequest(HttpRequest request) {
  print('Got request for ${request.uri.path} ${request.method}');
  if (request.uri.path == '/bga') {
    dartHandler(request);
  } else {
    request.response.write('Not found');
    request.response.close();
  }
}

dartHandler(HttpRequest request) {
  var result = {
    'count': 2,
    'data': [
      {'name': 'BGA', 'age': 27},
      {'name': 'bingoogolapple', 'age': 27}
    ]
  };

//  request.response.headers.contentType = ;
//  request.response.write(json.encode(result));
//  request.response.close();

  request.response
    ..headers.contentType = new ContentType('application', 'json', charset: 'utf-8')
    ..write(json.encode(result))
    ..close();
}

class Bean {
  String name;
  int age;

  Bean(this.name, this.age);
}
