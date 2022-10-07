import 'package:flutter/material.dart';
import 'package:flutter_app/mock/net_images.dart';

// 可以用 SafeArea 包裹来展示到安全区域

class GridViewPage extends StatelessWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: demo4(),
    );
  }

  GridView demo4() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        maxCrossAxisExtent: 300, // 每一项在交叉轴上的最大尺寸
        mainAxisExtent:
            100, // 条目在主轴方向的尺寸，如果不指定该参数的话就是正方形或按 childAspectRatio 来设置；优先级小于 childAspectRatio
        childAspectRatio: 2 /
            1, // 条目的交叉轴尺寸与主轴尺寸比，不指定的话就是正方形或按 mainAxisExtent 来设置；优先级大于 mainAxisExtent
      ),
      itemCount: netImages.length,
      itemBuilder: (context, index) {
        return Image.network(
          netImages[index],
          fit: BoxFit.cover,
        );
      },
    );
  }

  GridView demo3() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        crossAxisCount: 3, // 交叉轴条目个数
        mainAxisExtent:
            100, // 条目在主轴方向的尺寸，如果不指定该参数的话就是正方形或按 childAspectRatio 来设置；优先级小于 childAspectRatio
        childAspectRatio: 2 /
            1, // 条目的交叉轴尺寸与主轴尺寸比，不指定的话就是正方形或按 mainAxisExtent 来设置；优先级大于 mainAxisExtent
      ),
      itemCount: netImages.length,
      itemBuilder: (context, index) {
        return Image.network(
          netImages[index],
          fit: BoxFit.cover,
        );
      },
    );
  }

  GridView demo2() {
    return GridView.extent(
      maxCrossAxisExtent: 300, // 每一项在交叉轴上的最大尺寸
      childAspectRatio: 2 / 1, // 条目的交叉轴尺寸与主轴尺寸比，不指定的话就是正方形
      padding: const EdgeInsets.all(8),
      crossAxisSpacing: 16,
      mainAxisSpacing: 8,
      children: List.generate(
        netImages.length,
        (index) => Image.network(
          netImages[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  GridView demo1() {
    return GridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2, // 交叉轴条目个数
      crossAxisSpacing: 16,
      mainAxisSpacing: 8,
      childAspectRatio: 2 / 1, // 条目的交叉轴尺寸与主轴尺寸比，不指定的话就是正方形
      // scrollDirection: Axis.horizontal,
      children: List.generate(
        netImages.length,
        (index) => Image.network(
          netImages[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
