import 'package:flutter/material.dart';

// https://flutterchina.club/cookbook/navigation/passing-data

class NavigationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个页面'),
      ),
      body: new NavigationList(),
    );
  }
}

class NavigationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(title: Text('打开新页面'), onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondScreen(param: '打开新页面')))),
        ListTile(
            title: Text('动画打开新页面'),
            onTap: () {
              Navigator.of(context).push(new PageRouteBuilder(
                  opaque: false,
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context, _, __) {
                    return new SecondScreen(param: '动画打开新页面');
                  },
                  transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                    return new FadeTransition(
                      opacity: animation,
                      child: new RotationTransition(
                        turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                        child: child,
                      ),
                    );
                  }));
            }),
        ListTile(title: Text('await获取返回值'), onTap: () => _asyncAwaitResult(context)),
        ListTile(
          title: Text('then获取返回值'),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute<String>(builder: (context) => new SelectionScreen())).then((result) {
              Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("$result")));
            });
          },
        ),
      ],
    );
  }

  _asyncAwaitResult(BuildContext context) async {
    final String result = await Navigator.push(context, new MaterialPageRoute<String>(builder: (context) => new SelectionScreen()));
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("$result")));
    print("类型为：" + result);
  }
}

// Navigator.pop接受一个可选的(第二个)参数result。如果我们返回结果，它将返回到一个Future到前一个页面
class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('选择一个选项'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new RaisedButton(onPressed: () => Navigator.pop(context, 'Yep!'), child: new Text('Yep!')),
            ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new RaisedButton(onPressed: () => Navigator.pop(context, 'Nope!'), child: new Text('Nope.')),
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String param;

  SecondScreen({Key key, @required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("第二个页面")),
      body: new Column(
        children: [
          new Text("参数为:$param"),
          new RaisedButton(onPressed: () => Navigator.pop(context), child: new Text('返回')),
        ],
      ),
    );
  }
}
