import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/init/app_init_manager.dart';
import 'package:flutter_app/page/basic/animated_page.dart';
import 'package:flutter_app/page/basic/bloc_page.dart';
import 'package:flutter_app/page/basic/bottom_sheet_page.dart';
import 'package:flutter_app/page/basic/button_page.dart';
import 'package:flutter_app/page/basic/card_page.dart';
import 'package:flutter_app/page/basic/checkbox_page.dart';
import 'package:flutter_app/page/basic/chip_page.dart';
import 'package:flutter_app/page/basic/container_page.dart';
import 'package:flutter_app/page/basic/data_table_page.dart';
import 'package:flutter_app/page/basic/dialog_page.dart';
import 'package:flutter_app/page/basic/dismissable_page.dart';
import 'package:flutter_app/page/basic/drawer_page.dart';
import 'package:flutter_app/page/basic/expansion_panel_page.dart';
import 'package:flutter_app/page/basic/form_page.dart';
import 'package:flutter_app/page/basic/gesture_page.dart';
import 'package:flutter_app/page/basic/grid_view_page.dart';
import 'package:flutter_app/page/basic/http_page.dart';
import 'package:flutter_app/page/basic/independent_material_app_page.dart';
import 'package:flutter_app/page/basic/inherited_widget_page.dart';
import 'package:flutter_app/page/basic/page_view_page.dart';
import 'package:flutter_app/page/basic/paginated_data_table_page.dart';
import 'package:flutter_app/page/basic/picker_page.dart';
import 'package:flutter_app/page/basic/radio_page.dart';
import 'package:flutter_app/page/basic/route_params_page.dart';
import 'package:flutter_app/page/basic/row_column_page.dart';
import 'package:flutter_app/page/basic/slider_page.dart';
import 'package:flutter_app/page/basic/sliver_grid_page.dart';
import 'package:flutter_app/page/basic/sliver_list_page.dart';
import 'package:flutter_app/page/basic/sliver_nested_scroll_view_page.dart';
import 'package:flutter_app/page/basic/snack_bar_page.dart';
import 'package:flutter_app/page/basic/stack_page.dart';
import 'package:flutter_app/page/basic/stepper_page.dart';
import 'package:flutter_app/page/basic/stream_page.dart';
import 'package:flutter_app/page/basic/switch_page.dart';
import 'package:flutter_app/page/basic/text_field_page.dart';
import 'package:flutter_app/page/basic/text_page.dart';
import 'package:flutter_app/page/basic/scroll_controller_page.dart';
import 'package:flutter_app/page/basic/tab_bar_view_page.dart';
import 'package:flutter_app/page/basic/notification_listener_page.dart';
import 'package:flutter_app/page/demo/home_page/bottom_app_bar_and_indexed_stack.dart';
import 'package:flutter_app/page/demo/home_page/bottom_app_bar_and_page_view.dart';
import 'package:flutter_app/page/demo/home_page/bottom_navigation_bar_and_indexed_stack.dart';
import 'package:flutter_app/page/demo/home_page/bottom_navigation_bar_and_page_view.dart';
import 'package:flutter_app/page/demo/home_page/bottom_navigation_bar_and_tab_bar_view.dart';
import 'package:flutter_app/page/demo/home_page/tab_bar_and_indexed_stack.dart';
import 'package:flutter_app/page/demo/home_page/tab_bar_and_page_view.dart';
import 'package:flutter_app/page/demo/home_page/tab_bar_and_tab_bar_view.dart';
import 'package:flutter_app/platform/url_strategy/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  AppInitManager.instance.init();
  // 根组件为 MaterialApp 时才会生效，需要引入 rendering 包
  debugPaintSizeEnabled = false;
  setPathUrlStrategy();
  runApp(const App());
}

final Map<String, WidgetBuilder> basicRoutes = {
  '/basic/homePage': (context) => const HomePage(),
  '/basic/independentMaterialAppPage': (context) =>
      const IndependentMaterialAppPage(),
  '/basic/routeParamsPage': (context) {
    // 获取路由参数
    var args = ModalRoute.of(context)?.settings.arguments;
    debugPrint('RouteParamsPage routes 参数为: $args');
    return const RouteParamsPage();
  },
  '/basic/textPage': (context) => const TextPage(),
  '/basic/containerPage': (context) => const ContainerPage(),
  '/basic/stackPage': (context) => const StackPage(),
  '/basic/tabBarViewPage': (context) => const TabBarViewPage(),
  '/basic/drawerPage': (context) => const DrawerPage(),
  '/basic/pageViewPage': (context) => const PageViewPage(),
  '/basic/gridViewPage': (context) => const GridViewPage(),
  '/basic/sliverGridPage': (context) => const SliverGridPage(),
  '/basic/sliverListPage': (context) => const SliverListPage(),
  '/basic/sliverNestedScrollViewPage': (context) =>
      const SliverNestedScrollViewPage(),
  '/basic/scrollControllerPage': (context) => const ScrollControllerPage(),
  '/basic/textFieldPage': (context) => const TextFieldPage(),
  '/basic/formPage': (context) => const FormPage(),
  '/basic/buttonPage': (context) => const ButtonPage(),
  '/basic/checkboxPage': (context) => const CheckboxPage(),
  '/basic/radioPage': (context) => const RadioPage(),
  '/basic/switchPage': (context) => const SwitchPage(),
  '/basic/sliderPage': (context) => const SliderPage(),
  '/basic/showPickerPage': (context) => const ShowPickerPage(),
  '/basic/dialogPage': (context) => const DialogPage(),
  '/basic/bottomSheetPage': (context) => const BottomSheetPage(),
  '/basic/snackBarPage': (context) => const SnackBarPage(),
  '/basic/expansionPanelPage': (context) => const ExpansionPanelPage(),
  '/basic/cardPage': (context) => const CardPage(),
  '/basic/chipPage': (context) => const ChipPage(),
  '/basic/stepperPage': (context) => const StepperPage(),
  '/basic/dataTablePage': (context) => const DataTablePage(),
  '/basic/paginatedDataTablePage': (context) => const PaginatedDataTablePage(),
  '/basic/inheritedWidgetPage': (context) => const InheritedWidgetPage(),
  '/basic/notificationListenerPage': (context) =>
      const NotificationListenerPage(),
  '/basic/blocPage': (context) => const BlocPage(),
  '/basic/streamPage': (context) => const StreamPage(),
  '/basic/animatedPage': (context) => const AnimatedPage(),
  '/basic/rowColumnPage': (context) => const RowColumnPage(),
  '/basic/dismissiblePage': (context) => const DismissiblePage(),
  '/basic/gesturePage': (context) => const GesturePage(),
  '/basic/httpPage': (context) => const HttpPage(),
};

final Map<String, WidgetBuilder> demoRoutes = {
  '/demo/homePage/tabBarAndTabBarView': (context) =>
      const TabBarAndTabBarView(),
  '/demo/homePage/tabBarAndPageView': (context) => const TabBarAndPageView(),
  '/demo/homePage/tabBarAndIndexedStack': (context) =>
      const TabBarAndIndexedStack(),
  '/demo/homePage/bottomNavigationBarAndIndexedStack': (context) =>
      const BottomNavigationBarAndIndexedStack(),
  '/demo/homePage/bottomNavigationBarAndPageView': (context) =>
      const BottomNavigationBarAndPageView(),
  '/demo/homePage/bottomNavigationBarAndTabBarView': (context) =>
      const BottomNavigationBarAndTabBarView(),
  '/demo/homePage/bottomAppBarAndIndexedStack': (context) =>
      const BottomAppBarAndIndexedStack(),
  '/demo/homePage/bottomAppBarAndPageView': (context) =>
      const BottomAppBarAndPageView(),
};

final Map<String, WidgetBuilder> allRoutes = {
  ...basicRoutes,
  ...demoRoutes,
};

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 根组件设置为 MaterialApp；跳转到其他页面后如果不想展示返回按钮，也可以把 MaterialApp 再作为他页面的根组件
    return MaterialApp(
      // 不展示右上角的 DEBUG 标签
      debugShowCheckedModeBanner: false,
      // 定义主题
      theme: ThemeData(
        primarySwatch: Colors.purple,
        highlightColor: Colors.amber,
        splashColor: Colors.blue,
      ),
      title: 'MaterialAppTitle',
      // 当前运行环境配置
      locale: const Locale("zh", "CH"),
      // 程序支持的语言环境配置
      supportedLocales: const [Locale("zh", "CH")],
      // Material 风格代理配置
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // 首页
      home: const HomePage(),
      // 路由映射
      routes: allRoutes,
      // 默认路由
      // initialRoute: '/basic/homePage',
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const SafeArea(
            child: TabBar(
              // 设置成和文本长度一样
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(icon: Icon(Icons.device_hub), text: 'basic'),
                Tab(icon: Icon(Icons.document_scanner_outlined), text: 'demo')
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          // ListView 的子控件的宽度会撑满父容器宽度，不能单独设置子控件宽度
          ListView(
            children: [
              ListTile(
                title: const Text('push 打开 IndependentMaterialAppPage'),
                onTap: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      // 必选
                      builder: (context) => const IndependentMaterialAppPage(),
                      // 可选，通过该参数来设置路由和传递参数
                      settings: const RouteSettings(
                        // 可选
                        name: 'test',
                        // 可选
                        arguments: {'title': '我是参数'},
                      ),
                    ),
                  );
                  debugPrint('结果为: $result');
                },
              ),
              ...basicRoutes.keys.map(
                (routeName) => ListTile(
                  title: Text('pushNamed 打开 $routeName'),
                  onTap: () {
                    if (routeName == '/basic/routeParamsPage' ||
                        routeName == '/basic/independentMaterialAppPage') {
                      // 通过 arguments 传递路由参数
                      Navigator.pushNamed(
                        context,
                        routeName,
                        arguments: {'title': '我是参数'},
                      ).then((value) => debugPrint('then 方式结果为: $value'));
                    } else {
                      Navigator.pushNamed(context, routeName);
                    }
                  },
                ),
              ),
            ],
          ),
          // Column 的子控件的宽度默认不会撑满父容器宽度，子元素默认居中展示
          Column(
            children: [
              ...demoRoutes.keys.map(
                (routeName) => ListTile(
                  title: Text('打开 $routeName'),
                  onTap: () => Navigator.pushNamed(context, routeName),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
