import 'package:flutter/material.dart';

class GestureDetectorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('处理手势'),
      ),
      body: new ListView(
        children: [
          new GestureDetectorButton(),
          new InkWellButton(),
          new Container(
            height: 500.0,
            child: new DismissibleList(),
          ),
        ],
      ),
    );
  }
}

class GestureDetectorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Our GestureDetector wraps our button
    return new GestureDetector(
      // When the child is tapped, show a snackbar
      onTap: () {
        final snackBar = new SnackBar(content: new Text("Tap"));

        Scaffold.of(context).showSnackBar(snackBar);
      },
      // Our Custom Button!
      child: new Container(
        padding: new EdgeInsets.all(12.0),
        decoration: new BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Text('My Button'),
      ),
    );
  }
}

class InkWellButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The InkWell Wraps our custom flat button Widget
    return new InkWell(
      // When the user taps the button, show a snackbar
      onTap: () {
        Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Tap'),
            ));
      },
      child: new Container(
        padding: new EdgeInsets.all(12.0),
        child: new Text('Flat Button'),
      ),
    );
  }
}

class DismissibleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> items =
        new List<String>.generate(20, (i) => "Item ${i + 1}");
    return new ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return new Dismissible(
          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify Widgets.
          key: new Key(item),
          // We also need to provide a function that will tell our app
          // what to do after an item has been swiped away.
          onDismissed: (direction) {
            items.removeAt(index);

            Scaffold.of(context).showSnackBar(
                new SnackBar(content: new Text("$item dismissed")));
          },
          // Show a red background as the item is swiped away
          background: new Container(color: Colors.red),
          child: new ListTile(title: new Text('$item')),
        );
      },
    );
  }
}
