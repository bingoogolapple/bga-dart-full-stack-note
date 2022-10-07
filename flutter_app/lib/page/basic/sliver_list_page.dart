import 'package:flutter/material.dart';
import 'package:flutter_app/mock/net_images.dart';

// 可以用 SliverSafeArea 包裹来展示到安全区域

class SliverListPage extends StatelessWidget {
  const SliverListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('SliverList'),
      //   centerTitle: true,
      //   backgroundColor: Colors.deepOrange,
      // ),
      body: CustomScrollView(
        slivers: [_buildSliverAppBar(), demo1(), demo2()],
      ),
    );
  }

  SliverPadding demo2() {
    // SliverList 不支持设置 padding，需要通过包裹一层 SliverPadding 来设置 padding
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return SizedBox(
              height: 150,
              child: Image.network(
                netImages[index],
                fit: BoxFit.cover,
              ),
            );
          },
          childCount: netImages.length,
        ),
      ),
    );
  }

  SliverPadding demo1() {
    // SliverList 不支持设置 padding，需要通过包裹一层 SliverPadding 来设置 padding
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            netImages.length,
            (index) => Padding(
              padding: const EdgeInsets.all(8),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 12,
                shadowColor: Colors.red,
                child: AspectRatio(
                  aspectRatio: 4 / 1,
                  child: Image.network(
                    netImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.deepPurple,
      actions: [
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () {},
        ),
      ],
      // 展开 flexibleSpace 之后是否显示阴影
      forceElevated: true,
      // leading: const Icon(Icons.add),

      /// 如果有 leading 这个不会管用，相当于忽略这个参数
      /// 如果没有 leading，当有侧边栏的时候，false 表示不会显示默认的图片，true 表示会显示默认图片并响应打开侧边栏的事件
      automaticallyImplyLeading: true,
      // 是否随着滑动隐藏标题
      floating: true,
      // 与 floating 结合使用，floating 为 false 时 snap 必须设置为 false
      snap: true,
      centerTitle: false,
      title: _buildTitle(),
      // titleBar 是否固定在顶部
      pinned: true,
      // 可滚动视图的高度，伸缩区域大小
      expandedHeight: 200.0,
      // 可以展开区域，通常是 FlexibleSpaceBar
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        stretchModes: const <StretchMode>[StretchMode.zoomBackground],
        centerTitle: true,
        title: _buildTitle(),
        background: Image.network(
          netImages[netImages.length - 2],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildTitle() {
    return const Text(
      "SliverList",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}
