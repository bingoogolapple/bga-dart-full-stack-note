import 'package:flutter/material.dart';
import 'scaffold_drawer.dart';

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
        new ListTile(title: new Text('DrawerApp'), onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new DrawerApp()))),
      ],
    );
  }
}
