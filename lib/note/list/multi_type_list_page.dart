import 'package:flutter/material.dart';

abstract class ListItem {}

// A ListItem that contains data to display a heading
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

// A ListItem that contains data to display a message
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}

class MultiTypeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ListItem> items = new List<ListItem>.generate(
      1000,
      (i) => i % 5 == 0
          ? new HeadingItem("Heading $i")
          : new MessageItem("Sender $i", "Message body $i"),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('多类型列表'),
      ),
      body: new ListView.builder(
        // Let the ListView know how many items it needs to build
        itemCount: items.length,
        // Provide a builder function. This is where the magic happens! We'll
        // convert each item into a Widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = items[index];

          if (item is HeadingItem) {
            return new ListTile(
              title: new Text(
                item.heading,
                style: Theme.of(context).textTheme.headline,
              ),
            );
          } else if (item is MessageItem) {
            return new ListTile(
              title: new Text(item.sender),
              subtitle: new Text(item.body),
            );
          }
        },
      ),
    );
  }
}
