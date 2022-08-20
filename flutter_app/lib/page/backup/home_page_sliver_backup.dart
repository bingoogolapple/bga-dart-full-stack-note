import 'package:flutter/material.dart';
import 'package:flutter_app/mock/net_images.dart';
import 'package:flutter_app/widget/banner_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePageSliverBackup extends StatefulWidget {
  @override
  _HomePageSliverBackupState createState() => _HomePageSliverBackupState();
}

class _HomePageSliverBackupState extends State<HomePageSliverBackup> {
  @override
  void initState() {
    super.initState();
    print('initState => _HomePageState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildNestedScrollViewSliver(),
//      body: _buildCustomScrollViewSliver(),
    );
  }

  _buildNestedScrollViewSliver() {
    return Scaffold(
      body: NestedScrollView(
          // innerBoxIsScrolled 内部嵌套的可滚动列表是否在滚动
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[_buildSliverAppBar()];
          },
          body: _buildListView()),
    );
  }

  // ignore: unused_element
  _buildCustomScrollViewSliver() {
    return CustomScrollView(slivers: <Widget>[
      _buildSliverAppBar(),
//      _buildSliverListWithBuilderDelegate(),
      _buildSliverListWithListDelegate(),
    ]);
  }

  _buildSliverListWithListDelegate() {
    return SliverList(
      delegate: SliverChildListDelegate(_buildContentList()),
    );
  }

  // ignore: unused_element
  _buildSliverListWithBuilderDelegate() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return Container(
              height: 160,
              child: BannerWidget(
                List.generate(4, (index) {
                  return NET_IMAGES[index];
                }),
                Colors.deepPurple,
              ),
            );
          }
          return Container(height: 150, color: Colors.green[100 * index]);
        },
        childCount: 10,
      ),
    );
  }

  _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.deepPurple,
      actions: [
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {},
        ),
      ],
      // 展开 flexibleSpace 之后是否显示阴影
      forceElevated: true,
      leading: Icon(Icons.add),

      /// 如果有 leading 这个不会管用，相当于忽略这个参数
      /// 如果没有 leading，当有侧边栏的时候，false 表示不会显示默认的图片，true 表示会显示默认图片并响应打开侧边栏的事件
      automaticallyImplyLeading: true,
      // 可滚动视图的高度，伸缩区域大小
      expandedHeight: 200.0,
      // 是否随着滑动隐藏标题
      floating: true,
      // 与 floating 结合使用，floating 为 false 时 snap 必须设置为 false
      snap: true,
      centerTitle: false,
      title: _buildTitle(),
      // titleBar 是否固定在顶部
      pinned: true,
      // 可以展开区域，通常是 FlexibleSpaceBar
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        stretchModes: const <StretchMode>[StretchMode.zoomBackground],
        centerTitle: true,
        title: _buildTitle(),
        background: FadeInImage.memoryNetwork(
          fit: BoxFit.cover,
          placeholder: kTransparentImage,
          image: NET_IMAGES[10],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text("首页",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ));
  }

  Widget _buildListView() {
    return MediaQuery.removePadding(
      removeTop: true, // 移除顶部状态栏 padding
      context: context,
      child: ListView(
        children: _buildContentList(),
      ),
    );
  }

  _buildContentList() {
    return [
      Container(
        height: 160,
        child: BannerWidget(
          List.generate(4, (index) {
            return NET_IMAGES[index];
          }),
          Colors.deepPurple,
        ),
      ),
      Container(height: 150, color: Colors.green[100]),
      Container(height: 150, color: Colors.green[200]),
      Container(height: 150, color: Colors.green[300]),
      Container(height: 150, color: Colors.green[400]),
      Container(height: 150, color: Colors.green[500]),
      Container(height: 150, color: Colors.green[600]),
      Container(height: 150, color: Colors.green[700]),
      Container(height: 150, color: Colors.green[800]),
      Container(height: 150, color: Colors.green[900]),
    ];
  }
}
