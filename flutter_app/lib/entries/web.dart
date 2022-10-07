import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/mock/net_images.dart';
import 'package:flutter_app/page/basic_case/bloc_page.dart';
import 'package:flutter_app/page/basic_case/bottom_sheet_page.dart';
import 'package:flutter_app/page/basic_case/button_page.dart';
import 'package:flutter_app/page/basic_case/card_page.dart';
import 'package:flutter_app/page/basic_case/checkbox_page.dart';
import 'package:flutter_app/page/basic_case/chip_page.dart';
import 'package:flutter_app/page/basic_case/container_page.dart';
import 'package:flutter_app/page/basic_case/data_table_page.dart';
import 'package:flutter_app/page/basic_case/dialog_page.dart';
import 'package:flutter_app/page/basic_case/expansion_panel_page.dart';
import 'package:flutter_app/page/basic_case/form_page.dart';
import 'package:flutter_app/page/basic_case/grid_view_page.dart';
import 'package:flutter_app/page/basic_case/inherited_widget_page.dart';
import 'package:flutter_app/page/basic_case/page_view_page.dart';
import 'package:flutter_app/page/basic_case/paginated_data_table_page.dart';
import 'package:flutter_app/page/basic_case/picker_page.dart';
import 'package:flutter_app/page/basic_case/radio_page.dart';
import 'package:flutter_app/page/basic_case/slider_page.dart';
import 'package:flutter_app/page/basic_case/sliver_grid_page.dart';
import 'package:flutter_app/page/basic_case/sliver_list_page.dart';
import 'package:flutter_app/page/basic_case/snack_bar_page.dart';
import 'package:flutter_app/page/basic_case/stack_page.dart';
import 'package:flutter_app/page/basic_case/stepper_page.dart';
import 'package:flutter_app/page/basic_case/stream_page.dart';
import 'package:flutter_app/page/basic_case/switch_page.dart';
import 'package:flutter_app/page/basic_case/text_field_page.dart';
import 'package:flutter_app/page/basic_case/text_page.dart';
import 'package:flutter_app/platform/url_strategy/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // 根组件为 MaterialApp 时才会生效，需要引入 rendering 包
  debugPaintSizeEnabled = false;
  setPathUrlStrategy();
  runApp(const App());
}

final Map<String, WidgetBuilder> routes = {
  '/pageOne': (BuildContext context) {
    // 获取路由参数
    var args = ModalRoute.of(context)?.settings.arguments;
    debugPrint('PageOne routes 参数为: $args');
    return const PageOne();
  },
  '/pageTwo': (BuildContext context) => const PageTwo(),
  '/textPage': (BuildContext context) => const TextPage(),
  '/containerPage': (BuildContext context) => const ContainerPage(),
  '/stackPage': (BuildContext context) => const StackPage(),
  '/pageViewPage': (BuildContext context) => const PageViewPage(),
  '/gridViewPage': (BuildContext context) => const GridViewPage(),
  '/sliverGridPage': (BuildContext context) => const SliverGridPage(),
  '/sliverListPage': (BuildContext context) => const SliverListPage(),
  '/textFieldPage': (BuildContext context) => const TextFieldPage(),
  '/formPage': (BuildContext context) => const FormPage(),
  '/buttonPage': (BuildContext context) => const ButtonPage(),
  '/checkboxPage': (BuildContext context) => const CheckboxPage(),
  '/radioPage': (BuildContext context) => const RadioPage(),
  '/switchPage': (BuildContext context) => const SwitchPage(),
  '/sliderPage': (BuildContext context) => const SliderPage(),
  '/showPickerPage': (BuildContext context) => const ShowPickerPage(),
  '/dialogPage': (BuildContext context) => const DialogPage(),
  '/bottomSheetPage': (BuildContext context) => const BottomSheetPage(),
  '/snackBarPage': (BuildContext context) => const SnackBarPage(),
  '/expansionPanelPage': (BuildContext context) => const ExpansionPanelPage(),
  '/cardPage': (BuildContext context) => const CardPage(),
  '/chipPage': (BuildContext context) => const ChipPage(),
  '/stepperPage': (BuildContext context) => const StepperPage(),
  '/dataTablePage': (BuildContext context) => const DataTablePage(),
  '/paginatedDataTablePage': (BuildContext context) =>
      const PaginatedDataTablePage(),
  '/inheritedWidgetPage': (BuildContext context) => const InheritedWidgetPage(),
  '/blocPage': (BuildContext context) => const BlocPage(),
  '/streamPage': (BuildContext context) => const StreamPage(),
};

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 根组件设置为 MaterialApp；跳转到其他页面后如果不想展示返回按钮，也可以把 MaterialApp 再作为他页面的根组件
    return MaterialApp(
      // 不展示右上角的 DEBUG 标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          highlightColor: Colors.amber,
          splashColor: Colors.blue),
      title: 'MaterialAppTitle',
      // 当前运行环境配置
      locale: const Locale("zh", "CH"),
      // 程序支持的语言环境配置
      supportedLocales: const [Locale("zh", "CH")],
      // Material 风格代理配置
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: const Scaffold(body: HomePage()),
      // initialRoute: '/pageTwo',
      routes: routes,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBottomNavigationBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // 添加了 drawer 后会自动添加 leader，这里不能手动添加 leading，否则点击后就不会打开 drawer
          // leading: IconButton(
          //   // onPressed: null, // onPressed 设置为 null 表示禁用
          //   onPressed: () => {debugPrint('点击了左上方菜单图标')},
          //   enableFeedback: false,
          //   disabledColor: Colors.greenAccent,
          //   icon: const Icon(Icons.menu),
          //   color: Colors.pink,
          //   tooltip: '我是提示文案',
          // ),
          title: const Text('HomePage'),
          // 设置标题水平居中
          centerTitle: true,
          // 去除阴影，默认值为 4
          elevation: 0,
          // 判断平台类型需要引入 foundation 包
          backgroundColor: defaultTargetPlatform == TargetPlatform.linux
              ? Colors.purpleAccent
              : Colors.lightGreenAccent,
          actions: [
            IconButton(
              onPressed: () => {debugPrint('点击了右上方按钮1')},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () => {debugPrint('点击了右上方按钮2')},
              icon: const Icon(Icons.alarm),
            ),
            IconButton(
              onPressed: () => {debugPrint('点击了右上方按钮3')},
              icon: const Icon(Icons.scanner),
            ),
          ],
          // TabBar 必须和 TabController 结合着使用
          bottom: const TabBar(
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.pink,
              // 设置成和文本长度一样
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.only(bottom: 4),
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'tab1',
                ),
                Tab(
                  icon: Icon(Icons.security),
                  text: 'tab2',
                )
              ]),
        ),
        body: TabBarView(children: [
          // ListView 的子控件的宽度会撑满父容器宽度，不能单独设置子控件宽度
          ListView(
            children: [
              const Text('HomePage tab1'),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                title: const Text('打开 PageThree'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PageThree()));
                },
              ),
              ...routes.keys.map((routeName) => ListTile(
                    title: Text('打开 $routeName'),
                    onTap: () {
                      if (routeName == '/pageOne') {
                        // 通过 arguments 传递路由参数
                        Navigator.pushNamed(context, '/pageOne',
                                arguments: {'title': '我是参数'})
                            .then((value) => debugPrint('then 方式结果为: $value'));
                      } else {
                        Navigator.pushNamed(context, routeName);
                      }
                    },
                    // onTap: () async {
                    //   if (routeName == '/pageOne') {
                    //     // 通过 arguments 传递路由参数
                    //     var result = await Navigator.pushNamed(
                    //         context, '/pageOne',
                    //         arguments: {'title': '我是参数'});
                    //     debugPrint('await 方式结果为: $result');
                    //   } else {
                    //     Navigator.pushNamed(context, routeName);
                    //   }
                    // },
                  )),
            ],
          ),
          // Column 的子控件的宽度默认不会撑满父容器宽度，子元素默认居中展示
          Column(
            children: [
              const Text('HomePage tab2'),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PageThree())),
                  child: const Text('打开 PageThree')),
              ...routes.keys.map((routeName) => ListTile(
                    title: Text('打开 $routeName'),
                    // onTap: () {
                    //   if (routeName == '/pageOne') {
                    //     // 通过 arguments 传递路由参数
                    //     Navigator.pushNamed(context, '/pageOne',
                    //             arguments: {'title': '我是参数'})
                    //         .then((value) => debugPrint('then 方式结果为: $value'));
                    //   } else {
                    //     Navigator.pushNamed(context, routeName);
                    //   }
                    // },
                    onTap: () async {
                      if (routeName == '/pageOne') {
                        // 通过 arguments 传递路由参数
                        var result = await Navigator.pushNamed(
                            context, '/pageOne',
                            arguments: {'title': '我是参数'});
                        debugPrint('await 方式结果为: $result');
                      } else {
                        Navigator.pushNamed(context, routeName);
                      }
                    },
                  )),
            ],
          )
        ]),
        drawer: Drawer(
          child: ListView(children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/8949716?v=4'),
              ),
              accountName: const Text('BGA'),
              accountEmail: const Text('bingoogolapple@gmail.com'),
              decoration: BoxDecoration(
                // color: Colors.pink,
                image: DecorationImage(
                  image: NetworkImage(NET_IMAGES[0]),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.yellow.withOpacity(0.6), BlendMode.hardLight),
                ),
              ),
            ),
            ListTile(
              trailing: const Icon(Icons.safety_check),
              leading: const Icon(Icons.balcony),
              title: const Text('111'),
              onTap: () => Navigator.pop(context),
            )
          ]),
        ),
        endDrawer: Drawer(
          child: Column(children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: const Text('DrawerHeader'),
            ),
            ListTile(
              trailing: const Icon(Icons.safety_check),
              leading: const Icon(Icons.balcony),
              title: const Text('111'),
              onTap: () => Navigator.pop(context),
            )
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.blue,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.purple,
          currentIndex: _currentBottomNavigationBarIndex,
          onTap: (int index) {
            setState(() {
              _currentBottomNavigationBarIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'explore',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'history',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.discord),
              label: 'discord',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.earbuds),
              label: 'earbuds',
            ),
          ],
        ),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    var args = ModalRoute.of(context)?.settings.arguments;
    debugPrint('PageOne build 参数为: $args');
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
                onTap: () => Navigator.pop(context, '我是结果'),
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
    // 如果子页面想做为独立模块，不想展示返回按钮，也可以把 MaterialApp 作为子页面的根组件
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
