import 'package:flutter/material.dart';
import 'appbar_actions.dart';
import 'appbar_bottom.dart';

class MaterialComponentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MaterialComponentApp'),
      ),
      body: new ContentList(),
    );
  }
}

class ContentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: [
        new ListTile(
          leading: new Icon(Icons.map),
          title: new Text('AppBarActionsApp'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new AppBarActionsApp(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.photo),
          title: new Text('AppBarBottomApp'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new AppBarBottomApp(),
              ),
            );
          },
        ),
      ],
    );
  }
}
