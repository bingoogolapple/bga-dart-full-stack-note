import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// https://github.com/dart-flitter/flutter_webview_plugin/blob/master/example/lib/main.dart

class WebViewPage extends StatefulWidget {
  final Map<String, dynamic> post;

  WebViewPage(this.post);

  @override
  createState() => new _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool isLoaded = false;
  bool loading = false;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  void showSnack(String msg) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(msg)));
  }

  @override
  initState() {
    super.initState();
    flutterWebViewPlugin.close();

    _onStateChanged = flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("state: ${state.type}");
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.post['desc'] == null ? '没有描述信息' : widget.post['desc'];

    List<Widget> titleContent = [];
    if (!isLoaded) {
      titleContent.add(Container(margin: EdgeInsets.only(right: 8.0), child: CupertinoActivityIndicator()));
    }
    titleContent.add(Expanded(child: Text(title, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.0))));

    return new WebviewScaffold(
      key: _scaffoldKey,
      url: widget.post['url'],
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: titleContent),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () {
//                flutterWebViewPlugin.reload();
              flutterWebViewPlugin.launch(widget.post['url']);
            },
          ),
          new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              flutterWebViewPlugin.goBack();
            },
          ),
          new IconButton(
            icon: new Icon(Icons.arrow_forward),
            onPressed: () {
              flutterWebViewPlugin.goForward();
            },
          )
        ],
      ),
    );
  }
}
