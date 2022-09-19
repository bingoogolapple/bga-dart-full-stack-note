import 'package:flutter/material.dart';
import 'package:flutter_app/mock/net_images.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        children: NET_IMAGES.map(
          (imageUrl) {
            return Card(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 5 / 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      child: const Text('A'),
                    ),
                    title: const Text('我是标题'),
                    subtitle: const Text('我是作者'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      '我是描述',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ButtonTheme(
                    child: ButtonBar(
                      children: <Widget>[
                        ElevatedButton(
                          child: Text('Like'.toUpperCase()),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: Text('Read'.toUpperCase()),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
