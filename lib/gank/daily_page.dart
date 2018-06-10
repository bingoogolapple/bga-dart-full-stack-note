import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'base_widget.dart';
import 'data.dart';
import 'http_util.dart';
import 'gank_item.dart';

typedef void OnClickSearch();

// 每日干货页面
class DailyPage extends StatefulWidget {
  static const String title = '每日干货';
  static const Color color = Colors.orange;

  final OnClickSearch onClickSearch;

  DailyPage({@required this.onClickSearch});

  @override
  createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  DateTime _selectedDate = DateTime.now();
  final String _url = 'http://gank.io/api/day';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DailyPage.color,
        automaticallyImplyLeading: false,
        title: Text(DailyPage.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.today), onPressed: () => _selectDate(context)),
          IconButton(icon: Icon(Icons.search), onPressed: () => widget.onClickSearch())
        ],
      ),
      body: DailyList(url: _url + '/' + _selectedDate.year.toString() + '/' + _selectedDate.month.toString() + '/' + _selectedDate.day.toString()),
    );
  }

//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime.now());
//    if (picked == null) {
//      Scaffold.of(context).showSnackBar(SnackBar(content: Text("没有选择")));
//      return;
//    }
//    if (picked == _selectedDate) {
//      Scaffold.of(context).showSnackBar(SnackBar(content: Text("和之前的日期一样")));
//      return;
//    }
//    setState(() {
//      _selectedDate = picked;
//      Scaffold.of(context).showSnackBar(SnackBar(content: Text("选择了${_selectedDate.toString()}")));
//    });
//  }

  _selectDate(BuildContext context) {
    showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime.now()).then((picked) {
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
      }
    });
  }
}

class DailyList extends StatefulWidget {
  final String url;

  DailyList({Key key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DailyListState();
}

class DailyListState extends State<DailyList> {
  List data;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: FutureBuilder(
          future: HttpUtil.asyncGet(widget.url),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return LoadingWidget();
              default:
                if (snapshot.hasError) {
                  return EmptyWidget(snapshot.error);
                } else {
                  return buildBody(context, snapshot);
                }
            }
          }),
      onRefresh: loadData,
    );
  }

  Widget buildBody(BuildContext context, AsyncSnapshot snapshot) {
    List content = List();
    DailyResponse response = DailyResponse.fromJson(jsonDecode(snapshot.data));

    if (response.error) {
      return EmptyWidget('网络请求错误');
    } else {
      if (response.category.length == 0) {
        return EmptyWidget('暂无数据');
      } else {
        response.category.forEach((row) {
          content.addAll(response.results[row]);
        });
        return buildListViewBuilder(context, content);
      }
    }
  }

  Widget buildListViewBuilder(context, List content) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(2.0),
      itemCount: content == null ? 0 : content.length,
      itemBuilder: (context, i) {
        return GankItem(PostData.fromJson(content[i]));
      },
    );
  }

  Future<Null> loadData() async {
    await HttpUtil.asyncGet(widget.url);
    if (!mounted) return;
    setState(() {});
  }
}
