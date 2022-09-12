import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        // ListView 的子控件的宽度会撑满父容器宽度和高度，不能单独设置子控件宽度和高度
        // Column 的子控件的宽度默认不会撑满父容器宽度，子元素默认居中展示
        // Row 的子控件的高度默认不会撑满父容器高度，子元素默认居中展示
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.deepPurple,
              child: const Icon(
                Icons.pool,
                size: 100,
                color: Colors.red,
              ),
            ),
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(16), // padding 不会扩展宽高，会挤压内容偏移
              margin: const EdgeInsets.all(8),
              // color: Colors.deepPurple[200], // color 和 BoxDecoration 不能共存
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                border: Border(
                  top: BorderSide(
                      color: Colors.blue,
                      width: 10, // border 不会扩展宽高，会积压内容偏移
                      style: BorderStyle.solid),
                  bottom: BorderSide(
                      color: Colors.yellow,
                      width: 20, // border 不会扩展宽高，会积压内容偏移
                      style: BorderStyle.solid),
                ),
                // 设置 borderRadius 后会导致子控件不展示
                // borderRadius: const BorderRadius.only(
                //   topLeft: Radius.elliptical(10, 30),
                //   topRight: Radius.circular(10),
                // ),
              ),
              child: const Icon(
                Icons.pool,
                size: 100,
                color: Colors.red,
              ),
            ),
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(16), // padding 不会扩展宽高，会挤压内容偏移
              margin: const EdgeInsets.all(8),
              // color: Colors.deepPurple[200], // color 和 BoxDecoration 不能共存
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(
                    color: Colors.blue, width: 10, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.pool,
                size: 100,
                color: Colors.red,
              ),
            ),
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(16), // padding 不会扩展宽高，会挤压内容偏移
              margin: const EdgeInsets.all(8),
              // color: Colors.deepPurple[200], // color 和 BoxDecoration 不能共存
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(
                    color: Colors.blue, width: 5, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(5, 5),
                    color: Colors.red,
                    blurRadius: 10,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 5, // 正数：往外扩，负数：往内扩
                  )
                ],
              ),
              child: const Icon(
                Icons.pool,
                size: 50,
                color: Colors.red,
              ),
            ),
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(16), // padding 不会扩展宽高，会挤压内容偏移
              margin: const EdgeInsets.all(8),
              // color: Colors.deepPurple[200], // color 和 BoxDecoration 不能共存
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(
                    color: Colors.blue, width: 5, style: BorderStyle.solid),
                // borderRadius: BorderRadius.circular(10), // borderRadius 和 BoxShape.circle 不能共存
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(5, 5),
                    color: Colors.red,
                    blurRadius: 10,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 5, // 正数：往外扩，负数：往内扩
                  )
                ],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pool,
                size: 50,
                color: Colors.red,
              ),
            ),
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(16), // padding 不会扩展宽高，会挤压内容偏移
              margin: const EdgeInsets.all(8),
              // color: Colors.deepPurple[200], // color 和 BoxDecoration 不能共存
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(
                    color: Colors.blue, width: 5, style: BorderStyle.solid),
                // borderRadius: BorderRadius.circular(10), // borderRadius 和 BoxShape.circle 不能共存
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(5, 5),
                    color: Colors.red,
                    blurRadius: 10,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 5, // 正数：往外扩，负数：往内扩
                  )
                ],
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [
                    Colors.yellow,
                    Colors.indigo,
                  ],
                ),
              ),
              child: const Icon(
                Icons.pool,
                size: 50,
                color: Colors.red,
              ),
            ),
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(16), // padding 不会扩展宽高，会挤压内容偏移
              margin: const EdgeInsets.all(8),
              // color: Colors.deepPurple[200], // color 和 BoxDecoration 不能共存
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(
                    color: Colors.blue, width: 5, style: BorderStyle.solid),
                // borderRadius: BorderRadius.circular(10), // borderRadius 和 BoxShape.circle 不能共存
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(5, 5),
                    color: Colors.red,
                    blurRadius: 10,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 5, // 正数：往外扩，负数：往内扩
                  )
                ],
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Colors.yellow,
                    Colors.indigo,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Icon(
                Icons.pool,
                size: 50,
                color: Colors.red,
              ),
            ),
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(16), // padding 不会扩展宽高，会挤压内容偏移
              margin: const EdgeInsets.all(8),
              // color: Colors.deepPurple[200], // color 和 BoxDecoration 不能共存
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                image: const DecorationImage(
                    image: NetworkImage(
                      'https://avatars.githubusercontent.com/u/8949716?v=4',
                      scale: 4,
                    ),
                    alignment: Alignment.bottomCenter,
                    // repeat: ImageRepeat.repeatX,
                    // fit: BoxFit.cover, // BoxFit.cover 图像保持比例，覆盖整个容器显示
                    colorFilter:
                        ColorFilter.mode(Colors.teal, BlendMode.hardLight)),
                border: Border.all(
                    color: Colors.blue, width: 5, style: BorderStyle.solid),
                // borderRadius: BorderRadius.circular(10), // borderRadius 和 BoxShape.circle 不能共存
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(5, 5),
                    color: Colors.red,
                    blurRadius: 10,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 5, // 正数：往外扩，负数：往内扩
                  )
                ],
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Colors.yellow,
                    Colors.indigo,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Icon(
                Icons.pool,
                size: 50,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
