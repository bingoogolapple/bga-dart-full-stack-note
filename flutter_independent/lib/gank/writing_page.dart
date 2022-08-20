//import 'package:flutter/material.dart';
//import 'package:html/dom.dart' as Dom;
//import 'package:html/parser.dart' as htmlParser;
//import 'webview_page.dart';
//import 'base_widget.dart';
//import 'http_util.dart';
//
//// 匠心写作页面
//class WritingPage extends StatefulWidget {
//  static const String title = '匠心写作';
//  static const Color color = Colors.purple;
//
//  @override
//  createState() => _WritingPageState();
//}
//
//class _WritingPageState extends State<WritingPage> {
//  List<Post> mPost;
//
//  @override
//  void initState() {
//    super.initState();
//    mPost = new List();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: new AppBar(
//        backgroundColor: WritingPage.color,
//        automaticallyImplyLeading: false,
//        title: Text(WritingPage.title),
//      ),
//      body: new FutureBuilder(
//          future: HttpUtil.asyncGet('http://gank.io/post/published'),
//          builder: (BuildContext context, AsyncSnapshot snapshot) {
//            switch (snapshot.connectionState) {
//              case ConnectionState.none:
//              case ConnectionState.waiting:
//                return new LoadingWidget();
//              default:
//                if (snapshot.hasError) {
//                  return new EmptyWidget(snapshot.error);
//                } else {
//                  parseData(snapshot.data);
//                  return new ListView.builder(
//                      itemCount: mPost.length,
//                      itemBuilder: (context, index) {
//                        return _buildPostRow(mPost[index]);
//                      });
//                }
//            }
//          }),
//    );
//  }
//
//  void parseData(String htmlText) {
//    var document = htmlParser.parse(htmlText);
//    List<Dom.Element> containerTableElementList = document.getElementsByClassName("u-full-width");
//    List<Dom.Element> titleTdElementList = containerTableElementList[0].getElementsByClassName("title");
//    List<Dom.Element> timeTdElementList = containerTableElementList[0].getElementsByClassName("time");
//
//    mPost.clear();
//
//    titleTdElementList.forEach((element) {
//      List<Dom.Element> head = element.getElementsByTagName('a');
//      List<Dom.Element> author = element.getElementsByTagName('small');
//      String desc = head[0].text;
//      String publishAt = timeTdElementList[titleTdElementList.indexOf(element)].text;
//      String who = author[0].text.replaceAll('\(', '').replaceAll('\)', '');
//      String url = 'http://gank.io/' + head[0].attributes['href'];
//      mPost.add(new Post(desc, publishAt, who, url));
//    });
//  }
//
//  Widget _buildPostRow(Post data) {
//    return new InkWell(
//      onTap: () {
//        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
//          return new WebViewPage(data.toJson());
//        }));
//      },
//      child: new Card(
//        margin: new EdgeInsets.all(2.0),
//        child: new Padding(
//          padding: new EdgeInsets.all(8.0),
//          child: new Column(
//            children: <Widget>[
//              new Container(
//                margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
//                child: new Align(
//                  alignment: Alignment.centerLeft,
//                  child: new Text(data.desc, style: new TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold)),
//                ),
//              ),
//              new Container(
//                margin: const EdgeInsets.fromLTRB(2.0, 10.0, 10.0, 4.0),
//              ),
//              new Row(
//                children: <Widget>[
//                  new Align(alignment: Alignment.centerLeft, child: new Text(data.who, style: new TextStyle(fontSize: 12.0, color: Colors.grey))),
//                  new Expanded(child: new Align(alignment: Alignment.centerRight, child: new Text(data.publishAt))),
//                ],
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class Post {
//  String publishAt;
//  String url;
//  String desc;
//  String who;
//
//  Post(this.desc, this.publishAt, this.who, this.url);
//
//  Map<String, dynamic> toJson() => {"desc": desc, "publishAt": publishAt, "who": who, "url": url};
//}
