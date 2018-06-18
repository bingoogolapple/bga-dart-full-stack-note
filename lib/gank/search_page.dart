import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'http_util.dart';
import 'data.dart';
import 'gank_item.dart';
import 'base_widget.dart';

const List<String> _allCategoryList = const <String>[
  'all',
  'Android',
  'iOS',
  '休息视频',
  '福利',
  '拓展资源',
  '前端',
  '瞎推荐',
  'App',
];

// 搜索页面
class SearchPage extends StatefulWidget {
  static const String title = '搜索';
  static const Color color = Colors.blue;

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentCategoryPosition = 0;
  var listData;
  var currentPage = 1;
  var keyWord = "";

  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();

  _SearchPageState() {
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
      if (maxScroll == pixels) {
        currentPage++;
        _doSearch(true);
      }
    });
  }

  _doSearch(bool isLoadMore) {
    var url = 'http://gank.io/api/search/query/';
    url += keyWord + '/category/' + _allCategoryList[_currentCategoryPosition] + '/count/10/page/' + currentPage.toString();

    HttpUtil.get(url, (data) {
      if (data != null) {
        SearchResponse searchResponse = SearchResponse.fromJson(jsonDecode(data));
        if (!searchResponse.error) {
          var _listData = searchResponse.results;
          setState(() {
            if (!isLoadMore) {
              listData = _listData;
            } else {
              List newListData = List();
              newListData.addAll(listData);
              newListData.addAll(_listData);
              listData = newListData;
            }
          });
        }
      }
    }, (e) {
      print("get news list error: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: SearchPage.color,
          automaticallyImplyLeading: false,
          title: Text(SearchPage.title),
        ),
        body: Column(
          children: <Widget>[
            buildSearchView(context),
            Wrap(children: buildTextChips(context)),
            const Padding(padding: const EdgeInsets.only(top: 32.0)),
            GestureDetector(
              onTap: () async {
                await showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildBottomPicker();
                  },
                );
              },
              child: _buildMenu(),
            ),
            Expanded(child: _buildListView(context, listData)),
          ],
        ));
  }

  void _showSnackBar(message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget buildSearchView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
      child: TextField(
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        autofocus: false,
        maxLines: 1,
        controller: _textEditingController,
        onChanged: (text) {
          print('关键字发生变化$text');
        },
        onSubmitted: (text) {
          print('提交$text');
        },
        decoration: InputDecoration(
          hintText: '搜索关键词',
          hintStyle: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          border: const OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(20.0))),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
          suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (_textEditingController.text == null || _textEditingController.text.isEmpty) {
                  _showSnackBar("请输入关键字");
                } else {
                  setState(() {
                    currentPage = 1;
                    keyWord = _textEditingController.text;
                    _doSearch(false);
                  });
                }
              }),
        ),
      ),
    );
  }

  List<Widget> buildTextChips(BuildContext context) {
    return _allCategoryList.map<Widget>((String name) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
        child: Chip(
          key: ValueKey<String>(name),
          backgroundColor: labelColorMap[name],
          label: Text(name),
        ),
      );
    }).toList();
  }

  Widget _buildMenu() {
    return Container(
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: const Border(
          top: const BorderSide(color: const Color(0xFFBCBBC1), width: 0.0),
          bottom: const BorderSide(color: const Color(0xFFBCBBC1), width: 0.0),
        ),
      ),
      height: 44.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: DefaultTextStyle(
            style: const TextStyle(letterSpacing: -0.24, fontSize: 17.0, color: CupertinoColors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('搜索范围'),
                Text(_allCategoryList[_currentCategoryPosition], style: const TextStyle(color: CupertinoColors.inactiveGray)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPicker() {
    final FixedExtentScrollController scrollController = FixedExtentScrollController(initialItem: _currentCategoryPosition);
    return Container(
      height: 216.0,
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(color: CupertinoColors.black, fontSize: 22.0),
        child: GestureDetector(
          onTap: () {
            print('点击了 BottomPicker');
          },
          child: SafeArea(
            child: CupertinoPicker(
              scrollController: scrollController,
              itemExtent: 32.0,
              backgroundColor: CupertinoColors.white,
              onSelectedItemChanged: (index) {
                setState(() {
                  _currentCategoryPosition = index;
                  currentPage = 1;

                  if (_textEditingController.text == null || _textEditingController.text.isEmpty) {
                    listData = null;
                  } else {
                    _doSearch(false);
                  }
                });
              },
              children: List<Widget>.generate(
                _allCategoryList.length,
                (index) {
                  return Center(child: Text(_allCategoryList[index]));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, List results) {
    if (results == null || results.length == 0) {
      return EmptyWidget('暂无数据');
    } else {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(2.0),
        controller: _scrollController,
        itemCount: results == null ? 0 : results.length,
        itemBuilder: (context, i) {
          return GankItem(PostData.fromJson(results[i]));
        },
      );
    }
  }
}
