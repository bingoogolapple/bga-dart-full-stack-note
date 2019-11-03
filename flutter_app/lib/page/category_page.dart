import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  static const _categoryItemHeight = 50.0;
  List<CategoryItem> _categoryItemList = List.generate(18, (index) => CategoryItem(index, '分类$index'));
  CategoryItem _currentCategoryItem;
  int _currentCategoryIndex = 0;
  ScrollController _categoryScrollController;
  ScrollController _categoryDetailScrollController;

  @override
  void initState() {
    super.initState();
    print('initState => _CategoryPageState');
    _currentCategoryItem = _categoryItemList[_currentCategoryIndex];
    _categoryScrollController = ScrollController();
    _categoryDetailScrollController = ScrollController();
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    _categoryDetailScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: _buildCategoryListWidget(),
          ),
          Expanded(
            flex: 3,
            child: _buildCategoryDetailListWidget(),
          ),
        ],
      ),
    );
  }

  ListView _buildCategoryDetailListWidget() {
    return ListView.builder(
      controller: _categoryDetailScrollController,
      itemCount: _currentCategoryItem.dataList.length,
      itemBuilder: (context, position) {
        ListItem listItem = _currentCategoryItem.dataList[position];
        if (listItem is BannerItem) {
          return Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.memoryNetwork(width: 70, height: 70, placeholder: kTransparentImage, image: listItem.url),
            ),
          );
        } else if (listItem is ChildCategoryItem) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text(listItem.title),
                padding: EdgeInsets.all(10),
              ),
              GridView.builder(
                // 处理滚动嵌套报错
                shrinkWrap: true,
                // 禁止滚动
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // 设置列数
                  crossAxisCount: 3,
                  // 设置宽高比
                  childAspectRatio: 1.5,
                ),
                itemCount: listItem.goodsItemList.length,
                itemBuilder: (context, goodsPosition) {
                  return Column(
                    children: [Icon(Icons.filter), SizedBox(height: 5), Text(listItem.goodsItemList[goodsPosition].title)],
                  );
                },
              ),
            ],
          );
        } else {
          return Text('未知类型');
        }
      },
    );
  }

  ListView _buildCategoryListWidget() {
    return ListView.builder(
      controller: _categoryScrollController,
      itemCount: _categoryItemList.length,
      itemBuilder: (context, position) {
        bool checked = position == _currentCategoryIndex;
        return GestureDetector(
          child: Container(
            color: checked ? Colors.white : Colors.grey[100],
            height: _categoryItemHeight,
            child: Center(
              child: Text(
                _categoryItemList[position].name,
                style: TextStyle(
                  color: checked ? Colors.black : Colors.grey[600],
                  fontWeight: checked ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              _currentCategoryIndex = position;
              _currentCategoryItem = _categoryItemList[_currentCategoryIndex];

              _categoryScrollController.animateTo(_categoryItemHeight * max(0, _currentCategoryIndex - 5),
                  duration: Duration(milliseconds: 300), curve: Curves.ease);

              // _categoryDetailScrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.ease);
              _categoryDetailScrollController.jumpTo(0);
            });
          },
        );
      },
    );
  }
}

abstract class ListItem {}

class CategoryItem implements ListItem {
  final String name;
  final List<ListItem> dataList;

  CategoryItem(categoryIndex, this.name)
      : dataList = List.generate(10, (index) {
          if (index == 0) {
            return BannerItem('http://bgashare.bingoogolapple.cn/banner/imgs/${categoryIndex + 1}.png');
          } else {
            return ChildCategoryItem('子分类${categoryIndex + 1}-${index + 1}');
          }
        });
}

class BannerItem implements ListItem {
  final String url;

  BannerItem(this.url);
}

class ChildCategoryItem implements ListItem {
  final String title;
  final List<GoodsItem> goodsItemList;

  ChildCategoryItem(this.title) : goodsItemList = List.generate(10, (index) => GoodsItem('商品${index + 1}'));
}

class GoodsItem implements ListItem {
  final String title;

  GoodsItem(this.title);
}
