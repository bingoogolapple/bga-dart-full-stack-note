import 'package:bga_flutter_package/bga_flutter_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/mock/net_images.dart';
import 'package:flutter_app/widget/banner_widget.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.runtimeType.toString().replaceAll('Page', '')),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        // 添加了 drawer 后会自动添加能点击打开 drawer 的 leading，单独添加 leading 后点击 leading 不会自动打开 drawer
        // 方式一：通过 _scaffoldKey.currentState?.openDrawer() 来打开 drawer
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () {
        //     _scaffoldKey.currentState?.openDrawer();
        //     // _scaffoldKey.currentState?.closeDrawer();
        //   },
        // ),
        // 方式二：通过 Builder + Scaffold.of(context).openDrawer() 来打开 drawer
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              // Scaffold.of(context).closeDrawer();
            },
          ),
        ),
        // 添加了 endDrawer 后会自动添加能点击打开 endDrawer 的 actions，，单独添加 actions 后点击 action 不会自动打开 endDrawer
        actions: [
          // 方式一：通过 _scaffoldKey.currentState?.openEndDrawer() 来打开 endDrawer
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: '方式一：ScaffoldKey',
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
              // _scaffoldKey.currentState?.closeEndDrawer();
            },
          ),
          // 方式二：通过 Builder + Scaffold.of(context).openEndDrawer() 来打开 endDrawer
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              tooltip: '方式二：Builder',
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
                // Scaffold.of(context).closeEndDrawer();
              },
            ),
          ),
          PopupMenuButton<String>(
              offset: const Offset(0, 48),
              color: Colors.deepOrangeAccent,
              onSelected: (value) {
                _showSnackBar('点击了 $value');
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    value: '添加朋友',
                    textStyle: const TextStyle(color: Colors.white),
                    child: Row(children: const [
                      Icon(Icons.person_add),
                      SizedBox(width: 10),
                      Text('添加朋友')
                    ]),
                  ),
                  PopupMenuItem(
                    value: '扫一扫',
                    textStyle: const TextStyle(color: Colors.white),
                    child: Row(children: const [
                      Icon(Icons.camera_alt),
                      SizedBox(width: 10),
                      Text('扫一扫')
                    ]),
                  )
                ];
              }),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('返回'),
            ),
            const SizedBox(height: 8),
            Text(Calculator().addOne(5).toString()),
            const SizedBox(height: 8),
            const BGALogoWidget(),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: BannerWidget(
                List.generate(4, (index) {
                  return netImages[index];
                }),
                Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // 可选，默认为 304
        width: 304,
        // 可选，整体背景色
        backgroundColor: Colors.white,
        // 必选
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/8949716?v=4'),
              ),
              // 最多展示 3 个
              otherAccountsPictures: const [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/8949716?v=4'),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/8949716?v=4'),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/8949716?v=4'),
                ),
              ],
              // 设置了该参数后 accountName 和 accountEmail 右侧才会有箭头、才能点击展开
              onDetailsPressed: () {
                _showSnackBar('onDetailsPressed');
              },
              accountName: const Text('BGA'),
              accountEmail: const Text('bingoogolapple@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.yellow,
                image: DecorationImage(
                  image: NetworkImage(netImages[1]),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.yellow.withOpacity(0.6),
                    BlendMode.hardLight,
                  ),
                ),
              ),
            ),
            ListTile(
              trailing: const Icon(Icons.safety_check),
              leading: const Icon(Icons.balcony),
              title: const Text('drawer item1'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        elevation: 100,
        child: Column(children: [
          // 有可能 DrawerHeader 宽度不够撑满 Drawer 的宽度，外卖套一下 Row + Expanded
          Row(
            children: [
              Expanded(
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(netImages[1]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "DrawerHeader",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: const Text('DrawerHeader'),
                ),
              )
            ],
          ),
          ListTile(
            trailing: const Icon(Icons.safety_check),
            leading: const Icon(Icons.balcony),
            title: const Text('endDrawer item1'),
            onTap: () => Navigator.pop(context),
          )
        ]),
      ),
    );
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.deepOrangeAccent,
        content: Text(text),
      ),
    );
  }
}
