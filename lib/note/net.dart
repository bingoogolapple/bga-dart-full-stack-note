import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:css_colors/css_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网络'),
      ),
      body: new ListView(
        children: [
          new Container(
            height: 120.0,
            child: new FutureBuilder<Post>(
              future: fetchPost(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new Text(
                    snapshot.data.title,
                    style: new TextStyle(color: CSSColors.green),
                  );
                } else if (snapshot.hasError) {
                  return new Text("${snapshot.error}");
                }

                // By default, show a loading spinner
                return new CircularProgressIndicator();
              },
            ),
          ),
          new RaisedButton(
            color: CSSColors.lightBlue,
            onPressed: () => launch('http://www.bingoogolapple.cn'), // 一定要加上协议
            child: new Text('访问BGA个人主页'),
          ),
        ],
      ),
    );
  }
}

Future<Post> fetchPost() async {
  final response = await http.get(
    'https://jsonplaceholder.typicode.com/posts/1',
    headers: {HttpHeaders.AUTHORIZATION: "Basic your_api_token_here"},
  );
  final responseJson = json.decode(response.body);
  return new Post.fromJson(responseJson);
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

//  factory Post.fromJson(Map<String, dynamic> json) {
//    return new Post(
//      userId: json['userId'],
//      id: json['id'],
//      title: json['title'],
//      body: json['body'],
//    );
//  }

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        body = json['body'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
