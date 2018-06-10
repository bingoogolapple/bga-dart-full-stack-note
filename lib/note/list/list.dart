import 'package:flutter/material.dart';
import 'horizontal_list_page.dart';
import 'long_list_page.dart';
import 'multi_type_list_page.dart';
import 'grid_list_page.dart';
import 'expansion_list_page.dart';

class ListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('垂直列表'),
      ),
      body: new VerticalList(),
    );
  }
}

class VerticalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: [
        new ListTile(
          leading: new Icon(Icons.map),
          title: new Text('水平列表'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new HorizontalListPage(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.photo),
          title: new Text('长列表'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new LongListPage(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.phone),
          title: new Text('多类型列表'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new MultiTypeListPage(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.phone),
          title: new Text('网格列表'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new GridListPage(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.phone),
          title: new Text('ExpansionTileList'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new ExpansionTileListPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
