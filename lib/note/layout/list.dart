import 'package:flutter/material.dart';
import 'layout_one.dart';
import 'layout_two.dart';
import 'layout_three.dart';
import 'layout_four.dart';
import 'layout_five.dart';
import 'layout_six.dart';

class LayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LayoutApp'),
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
          title: new Text('LayoutOneApp'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new LayoutOneApp(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.photo),
          title: new Text('LayoutTwoApp'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new LayoutTwoApp(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.phone),
          title: new Text('LayoutThreeApp'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new LayoutThreeApp(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.phone),
          title: new Text('LayoutFourApp'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new LayoutFourApp(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.phone),
          title: new Text('LayoutFiveApp'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new LayoutFiveApp(),
              ),
            );
          },
        ),
        new ListTile(
          leading: new Icon(Icons.phone),
          title: new Text('LayoutSixApp'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new LayoutSixApp(),
              ),
            );
          },
        ),
      ],
    );
  }
}
