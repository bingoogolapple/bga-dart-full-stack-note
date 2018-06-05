import 'package:flutter/material.dart';

// https://flutterchina.club/tutorials/layout

class LayoutFiveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Top Lakes'),
          ),
          body: new Column(children: [
            buildStack(),
            buildCard(),
          ])),
    );
  }

  Widget buildCard() {
    return new SizedBox(
      height: 210.0,
      child: new Card(
        elevation: 3.0,
        color: Colors.lightGreenAccent[100],
        child: new Column(
          children: [
            new ListTile(
              title: new Text('1625 Main Street',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              subtitle: new Text('My City, CA 99984'),
              leading: new Icon(
                Icons.restaurant_menu,
                color: Colors.blue[500],
              ),
            ),
            new Divider(),
            new ListTile(
              title: new Text('(408) 555-1212',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              leading: new Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            new ListTile(
              title: new Text('costa@example.com'),
              leading: new Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStack() {
    return new Stack(
      alignment: const Alignment(-0.8, 0.0),
      children: [
        new CircleAvatar(
          backgroundImage: new AssetImage('images/pic1.jpg'),
          radius: 100.0,
        ),
        new CircleAvatar(
          backgroundImage: new AssetImage('images/pic2.jpg'),
          radius: 50.0,
        ),
        new Container(
          decoration: new BoxDecoration(
            color: Colors.red,
          ),
          child: new Text(
            'Mia B',
            style: new TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
