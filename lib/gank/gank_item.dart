import 'package:flutter/material.dart';
import 'data.dart';
import 'post_page.dart';

class GankItem extends StatelessWidget {
  final PostData postData;

  GankItem(this.postData);

  @override
  Widget build(BuildContext context) {
    if (postData.type == '福利') {
      return _MeiZhiItem(postData);
    } else {
      return _DataItem(postData);
    }
  }
}

final Map<String, Color> labelColorMap = {
  'Android': const Color(0xff01c2d2),
  'iOS': const Color(0xff91cd3f),
  '前端': const Color(0xfffb6f57),
  '瞎推荐': const Color(0xffba6fda),
  '拓展资源': const Color(0xff7b79e5),
  '福利': const Color(0xff739dc7),
  'App': const Color(0xff3dc788),
  '休息视频': const Color(0xfffdaa3b),
};

class _DataItem extends StatelessWidget {
  final PostData postData;

  _DataItem(this.postData);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
            return new PostPage(postData.toJson());
          }));
        },
        child: new Card(
          margin: new EdgeInsets.all(4.0),
          child: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                // 标题
                new Container(
                  margin: new EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Text(postData.desc, style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                  ),
                ),
                // 作者
                new Container(
                  margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Text(postData.who.toString(), style: new TextStyle(fontSize: 12.0, color: Colors.grey)),
                  ),
                ),
                // 标签和时间
                Row(
                  children: [
                    Card(
                        color: _getLabelColor(),
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(postData.type, style: TextStyle(color: Colors.white)),
                        )),
                    // 占用剩余部分
                    Expanded(
                      // 靠右对其
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(getTimestampString(DateTime.parse(postData.publishedAt)), style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  String getTimestampString(DateTime date) {
    DateTime curDate = DateTime.now();
    Duration diff = curDate.difference(date);
    if (diff.inDays > 0) {
      return diff.inDays.toString() + "天前";
    } else if (diff.inHours > 0) {
      return diff.inHours.toString() + "小时前";
    } else if (diff.inMinutes > 0) {
      return diff.inMinutes.toString() + "分钟前";
    } else if (diff.inSeconds > 0) {
      return "刚刚";
    }
    return date.toString();
  }

  Color _getLabelColor() {
    Color labelColor = labelColorMap[postData.type];
    if (labelColor == null) {
      labelColor = Colors.red;
    }
    return labelColor;
  }
}

class _MeiZhiItem extends StatelessWidget {
  final PostData postData;

  _MeiZhiItem(this.postData);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.headline.copyWith(color: Colors.white);

    return InkWell(
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
            return new PostPage(postData.toJson());
          }));
        },
        child: new Card(
          margin: new EdgeInsets.all(4.0),
          child: new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new SizedBox(
                height: 300.0,
                child: new Stack(
                  children: <Widget>[
                    new Positioned.fill(
                        child: new FadeInImage.assetNetwork(
                      placeholder: 'images/loading.png',
                      image: postData.url,
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.repeat,
                    )),
                    new Positioned(
                      bottom: 6.0,
                      left: 6.0,
                      right: 6.0,
                      child: new FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.bottomLeft,
                        child: new Text(
                          postData.desc,
                          style: titleStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
