import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/mock/net_images.dart';
import 'package:flutter_app/platform/url_strategy/url_strategy.dart';

void main() {
  // 根组件为 MaterialApp 时才会生效，需要引入 rendering 包
  debugPaintSizeEnabled = false;
  setPathUrlStrategy();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 根组件设置为 MaterialApp；跳转到其他页面后如果不想展示返回按钮，也可以把 MaterialApp 再作为他页面的根组件
    return MaterialApp(
      // 不展示右上角的 DEBUG 标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      title: 'MaterialAppTitle',
      home: const Scaffold(body: HomePage()),
      routes: {
        '/pageOne': (BuildContext context) => const PageOne(),
        '/pageTwo': (BuildContext context) => const PageTwo()
      },
      // initialRoute: '/pageOne',
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        // 去除阴影，默认值为 4
        elevation: 0,
        // 判断平台类型需要引入 foundation 包
        backgroundColor: defaultTargetPlatform == TargetPlatform.linux
            ? Colors.purpleAccent
            : Colors.lightGreenAccent,
      ),
      // ListView 会撑满父容器宽度，Column 不会撑满父容器宽度
      body: ListView(
        children: [
          const Text('HomePage'),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/pageOne'),
              child: const Text('打开 PageOne')),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/pageTwo'),
              child: const Text('打开 PageTwo')),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PageThree())),
              child: const Text('打开 PageThree')),
        ],
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 需要用 Scaffold 包裹才会顶部菜单返回
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageOne'),
      ),
      body: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
            if (index == 0) {
              return const Text('PageOne');
            }
            if (index == 1) {
              return ListTile(
                onTap: () => Navigator.pop(context),
                leading: Image.network(NET_IMAGES[index]),
                trailing: Image.network(NET_IMAGES[index]),
                title: const Text('返回'),
                subtitle: const Text('子标题'),
              );
            }
            return Container(
              color: Colors.orangeAccent,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(NET_IMAGES[index]),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'title $index',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'subtitle $index',
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageTwo'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('PageTwo'),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('返回'))
          ],
        ),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 如果自页面想做为独立模块，不想展示返回按钮，也可以把 MaterialApp 作为子页面的根组件
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'PageThree',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('PageThree'),
          ),
          body: Center(
            child: Column(
              children: [
                const Text('PageThree'),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('返回'))
              ],
            ),
          )),
    );
  }
}
