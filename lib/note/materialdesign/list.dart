import 'package:flutter/material.dart';
import 'appbar_actions.dart';
import 'appbar_bottom.dart';
import 'appbar_indicator.dart';
import 'bottomnavigationbar.dart';
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
        new ListTile(
            title: new Text('AppBarActionsApp'), onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new AppBarActionsApp()))),
        new ListTile(
            title: new Text('AppBarBottomApp'), onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new AppBarBottomApp()))),
        new ListTile(
            title: new Text('AppBarIndicatorApp'), onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new AppBarIndicatorApp()))),
        new ListTile(
            title: new Text('BottomNavigationBarApp'),
            onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new BottomNavigationBarApp()))),
        new ListTile(title: new Text('DrawerApp'), onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new DrawerApp()))),
      ],
    );
  }
}
