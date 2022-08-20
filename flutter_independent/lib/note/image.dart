import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
//import 'package:cached_network_image/cached_network_image.dart';

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
              image: 'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
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
                    image: 'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
                  ),
                ),
              ],
            ),
          ),
//          new Container(
//            height: 120.0,
//            child: new CachedNetworkImage(
//              imageUrl: 'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
//              placeholder: (context, url) => CircularProgressIndicator(),
//              errorWidget: (context, url, error) => Text('加载失败'),
//            ),
//          ),
//          new Container(
//            height: 120.0,
//            child: new CachedNetworkImage(
//              imageUrl: 'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
//              imageBuilder: (context, imageProvider) {
//                return Container(
//                  decoration: BoxDecoration(
//                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//                  ),
//                );
//              },
//              placeholder: (context, url) => CircularProgressIndicator(),
//              errorWidget: (context, url, error) => Text('加载失败'),
//            ),
//          ),
        ],
      ),
    );
  }
}
