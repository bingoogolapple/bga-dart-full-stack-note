import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:independent/gank/dto/post_data.dart';
import 'package:independent/gank/dto/category_response.dart';
import 'base_widget.dart';
import 'http_util.dart';
import 'gank_item.dart';

// 分类阅读页面
class CategoryPage extends StatefulWidget {
  static const String title = '分类阅读';
  static const Color color = Colors.red;

  @override
  createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _allCategoryList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CategoryPage.color,
        automaticallyImplyLeading: false,
        title: Text(CategoryPage.title),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).primaryColor,
          isScrollable: true,
          tabs: _allCategoryList.map((_Category page) => Tab(text: page.text)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _allCategoryList.map((_Category page) => page.gankList).toList(),
      ),
    );
  }
}

// 所有分类列表
final List<_Category> _allCategoryList = [
  _Category(text: "all", gankList: _GankList(category: ('all'))),
  _Category(text: "福利", gankList: _GankList(category: ('福利'))),
  _Category(text: "Android", gankList: _GankList(category: ('Android'))),
  _Category(text: "瞎推荐", gankList: _GankList(category: ('瞎推荐'))),
  _Category(text: "iOS", gankList: _GankList(category: ('iOS'))),
  _Category(text: "前端", gankList: _GankList(category: ('前端'))),
  _Category(text: "拓展资源", gankList: _GankList(category: ('拓展资源'))),
  _Category(text: "App", gankList: _GankList(category: ('App'))),
  _Category(text: "休息视频", gankList: _GankList(category: ('休息视频'))),
];

class _Category {
  _Category({this.icon, this.text, this.gankList});

  final IconData icon;
  final String text;
  final _GankList gankList;
}

class _GankList extends StatefulWidget {
  String category;

  _GankList({Key key, this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GankListState();
}

class _GankListState extends State<_GankList> {
  var listData;
  var curPage = 1;
  var listTotalSize = 0;
  ScrollController _scrollController = ScrollController();

  _GankListState() {
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
      if (maxScroll == pixels) {
        curPage++;
        getNewsList(true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getNewsList(false);
  }

  getNewsList(bool isLoadMore) {
    var url = "http://gank.io/api/data/";
    url += widget.category + '/10/' + this.curPage.toString();
    HttpUtil.get(url, (data) {
      if (data != null) {
        CategoryResponse categoryResponse = CategoryResponse.fromJson(jsonDecode(data));
        if (!categoryResponse.error) {
          var _listData = categoryResponse.results;
          print(_listData);
          if (_listData.length > 0) {
            setState(() {
              if (!isLoadMore) {
                listData = _listData;
              } else {
                List list1 = List();
                list1.addAll(listData);
                list1.addAll(_listData);
                listData = list1;
              }
            });
          }
        }
      }
    }, (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("获取数据失败：$e")));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return LoadingWidget();
    } else {
      Widget listView = _buildListView(context, listData);
      return RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  Widget _buildListView(BuildContext context, List results) {
    switch (results.length) {
      case 1:
        return EmptyWidget('暂无数据');
      default:
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

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }
}
