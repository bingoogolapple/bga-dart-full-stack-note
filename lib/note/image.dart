import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片'),
      ),
      body: new ListView(
        children: [
          new Container(
            height: 120.0,
            child: new Image.network(
              'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
            ),
          ),
          new Container(
            height: 120.0,
            child: new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image:
                  'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
            ),
          ),
          new Container(
            height: 120.0,
            child: new Stack(
              children: <Widget>[
                new Center(child: new CircularProgressIndicator()),
                new Center(
                  child: new FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image:
                        'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
                  ),
                ),
              ],
            ),
          ),
          new Container(
            height: 120.0,
            child: new CachedNetworkImage(
              placeholder: new CircularProgressIndicator(),
              errorWidget: new Text('加载失败'),
              imageUrl:
                  'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
            ),
          ),
        ],
      ),
    );
  }
}
