import 'package:flutter/material.dart';
import 'package:flutter_app/mock/net_images.dart';

// 可以用 SliverSafeArea 包裹来展示到安全区域

class SliverGridPage extends StatelessWidget {
  const SliverGridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('SliverGrid'),
      //   centerTitle: true,
      //   backgroundColor: Colors.deepOrange,
      // ),
      body: CustomScrollView(
        slivers: [_buildSliverAppBar(), demo1(), demo2(), demo3(), demo4()],
      ),
    );
  }

  SliverPadding demo4() {
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 16,
          mainAxisSpacing: 8,
          maxCrossAxisExtent: 300, // 每一项在交叉轴上的最大尺寸
          mainAxisExtent:
              100, // 条目在主轴方向的尺寸，如果不指定该参数的话就是正方形或按 childAspectRatio 来设置；优先级小于 childAspectRatio
          childAspectRatio: 2 /
              1, // 条目的交叉轴尺寸与主轴尺寸比，不指定的话就是正方形或按 mainAxisExtent 来设置；优先级大于 mainAxisExtent
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Image.network(
              NET_IMAGES[index],
              fit: BoxFit.cover,
            );
          },
          childCount: NET_IMAGES.length,
        ),
      ),
    );
  }

  SliverPadding demo3() {
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 8,
          crossAxisCount: 3, // 交叉轴条目个数
          mainAxisExtent:
              100, // 条目在主轴方向的尺寸，如果不指定该参数的话就是正方形或按 childAspectRatio 来设置；优先级小于 childAspectRatio
          childAspectRatio: 2 /
              1, // 条目的交叉轴尺寸与主轴尺寸比，不指定的话就是正方形或按 mainAxisExtent 来设置；优先级大于 mainAxisExtent
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Image.network(
              NET_IMAGES[index],
              fit: BoxFit.cover,
            );
          },
          childCount: NET_IMAGES.length,
        ),
      ),
    );
  }

  SliverPadding demo2() {
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid.extent(
        maxCrossAxisExtent: 300, // 每一项在交叉轴上的最大尺寸
        childAspectRatio: 2 / 1, // 条目的交叉轴尺寸与主轴尺寸比，不指定的话就是正方形
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        children: List.generate(
          NET_IMAGES.length,
          (index) => Image.network(
            NET_IMAGES[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  SliverPadding demo1() {
    // SliverGrid 不支持设置 padding，需要通过包裹一层 SliverPadding 来设置 padding
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid.count(
        crossAxisCount: 2, // 交叉轴条目个数
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        childAspectRatio: 2 / 1, // 条目的交叉轴尺寸与主轴尺寸比，不指定的话就是正方形
        // scrollDirection: Axis.horizontal,
        children: List.generate(
          NET_IMAGES.length,
          (index) => Image.network(
            NET_IMAGES[index],
            fit: BoxFit.cover,
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
          NET_IMAGES[NET_IMAGES.length - 2],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text("SliverGrid",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ));
  }
}
