import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PostPage extends StatefulWidget {
  final Map<String, dynamic> post;

  PostPage(this.post);

  @override
  createState() => new _PostWebViewState();
}

class _PostWebViewState extends State<PostPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool isLoaded = false;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  StreamSubscription<WebViewStateChanged> _onStateChanged;

  void showSnack(String msg) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(msg)));
  }

  bool loading = false;

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
    print(widget.post['url']);
    String title = widget.post['desc'] == null ? '一个陌生的地方' : widget.post['desc'];

    List<Widget> titleContent = [];
    if (!isLoaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Expanded(child: new Text(title, overflow: TextOverflow.ellipsis, style: new TextStyle(fontSize: 16.0))));

    return new WebviewScaffold(
      key: _scaffoldKey,
      url: widget.post['url'],
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        //title: new Text(title),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
