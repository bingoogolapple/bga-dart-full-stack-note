import 'package:flutter/material.dart';
import 'common.dart';

class DrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DrawerApp')),
      drawer: new Drawer(child: new DrawerWidget()),
      body: new Center(
        child: new Text('DrawerApp'),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.only(),
      children: <Widget>[
        new DrawerHeader(
          child: new Column(children: <Widget>[
            new CircleAvatar(backgroundImage: new NetworkImage('https://avatars3.githubusercontent.com/u/8949716?s=460&v=4')),
            new Text('BGA'),
          ]),
        ),
        new UserAccountsDrawerHeader(
          accountName: new Text('bingoogolapple'),
          accountEmail: new Text('bingoogolapple@gmail.com'),
          currentAccountPicture: new CircleAvatar(backgroundImage: new NetworkImage('https://avatars3.githubusercontent.com/u/8949716?s=460&v=4')),
          otherAccountsPictures: <Widget>[
            new Text("最多只有三个"),
            new CircleAvatar(backgroundImage: new NetworkImage('https://avatars3.githubusercontent.com/u/8949716?s=460&v=4')),
            new CircleAvatar(backgroundImage: new NetworkImage('https://avatars3.githubusercontent.com/u/8949716?s=460&v=4')),
          ],
          onDetailsPressed: () {
            print('点击了详细');
          },
        ),
        new ListTile(
            title: new Text('名称路由'),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop(); // 关闭 Drawer
              Navigator.pushNamed(context, '/firstapp');
            }),
        new Divider(),
        new ListTile(title: new Text('A')),
        new Divider(),
        new ListTile(title: new Text('B')),
        new Divider(),
        new ListTile(title: new Text('C')),
        new Divider(),
        new ListTile(title: new Text('D')),
      ],
    );
  }
}
