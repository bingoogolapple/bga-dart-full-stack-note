import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(
        () => debugPrint('_controller addListener：${_controller.text}'));
    _focusNode.addListener(
        () => debugPrint('_focusNode addListener：${_focusNode.hasFocus}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextFieldPage'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.orange),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const TextField(
                  // 最大行数。默认情况下，将 maxLines 设置为直接值会将其自动扩展为该行数；设置成 null 的话当一行完成时会自动扩展
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintText: 'hintText',
                      labelText: 'labelText',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                // TextField 组件没有像 Android 中那样的 ID，无法通过实例根据需要检索文本，而必须在更改时将其存储在变量中或使用控制器
                TextField(
                  // 获取内容、赋值、添加监听等
                  controller: _controller,
                  // 主动获取焦点、监听焦点变更等
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    // 展示在 border 外面
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.red,
                    ),
                    // 没有输入内容且未聚焦时的提示文案，聚焦时的左上角浮动提示文案；labelText 和 label 只能存在一个
                    // label: const Text('label'),
                    labelText: 'labelText',
                    // 聚焦时 labelText 或 label 展示的位置
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    // 暂时在左下角的帮助文案，errorText 为空时会一直展示 helperText
                    helperText: 'helperText',
                    // 存在 labelText 或 label 时，需要聚焦且没有输入内容时才会展示
                    // 不存在 labelText 和 label 时，没有输入内容时才会展示
                    hintText: 'hintText',
                    // 只要不为 null，就会展示
                    // errorText: 'errorText',
                    // 是否密集，默认为 false，子控件是否暂用更少的空间
                    isDense: true,
                    contentPadding: const EdgeInsets.all(20),
                    // 只有聚焦或者有值时才会展示 prefix、prefixText、suffix、suffixText
                    prefixIcon: const Icon(Icons.add_call),
                    // prefix 和 prefixText 只能存在一个
                    // prefix: const Text('prefix'),
                    prefixText: 'prefixText',
                    suffixIcon: const Icon(Icons.add),
                    // suffix 和 suffixText 只能存在一个
                    // suffix: const Text('suffix'),
                    suffixText: 'suffixText',
                    // 右下角用于展示计数的文本，设置之后右下角是固定字符串，不会有一个输入数量的统计字符串
                    // counterText: 'counterText',
                    // semanticCounterText: 'semanticCounterText',
                    // 是否启用
                    enabled: true,
                    // 填充除了 border 和 icon 以外的其他区域
                    filled: true,
                    fillColor: Colors.lightGreen,
                    errorBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 20,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: 20,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                        width: 20,
                        style: BorderStyle.solid,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.teal,
                        width: 10,
                        style: BorderStyle.none,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Colors.brown,
                        width: 10,
                        style: BorderStyle.none,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.yellow,
                        width: 10,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  // 内容改变时的回调
                  onChanged: (text) => debugPrint('onChanged：$text'),
                  // 按回车键时的回调
                  onSubmitted: (text) => debugPrint('onSubmitted：$text'),
                  // 密码输入
                  obscureText: false,
                  // 密码输入时的脱敏符号
                  obscuringCharacter: '-',
                  // 最大行数。默认情况下，将 maxLines 设置为直接值会将其自动扩展为该行数；设置成 null 的话当一行完成时会自动扩展
                  maxLines: 1,
                  // 是否为只读，开启只读时不会自动隐藏光标
                  readOnly: false,
                  // 自动获取焦点
                  autofocus: true,
                  // 输入文本的样式
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                  // 没有设置 counterText 且设置了 maxLength 之后右下角会有一个输入数量的统计字符串
                  maxLength: 10,
                  // 允许的输入格式
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[1-31111111a-c]'))
                  ],
                  // 键盘类型
                  keyboardType: TextInputType.text,
                  // 替换右下角 Done 按钮
                  textInputAction: TextInputAction.continueAction,
                  // 文本对齐方式
                  textAlign: TextAlign.center,
                  // sentences 每个句子的首字母大写，characters 所有字符大写，words 每个单词首字母大写
                  textCapitalization: TextCapitalization.words,
                  // 修改光标样式
                  showCursor: true,
                  cursorColor: Colors.red,
                  cursorRadius: const Radius.circular(8),
                  cursorWidth: 16,
                  cursorHeight: 32,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('结果为：${_controller.text}');
                  },
                  child: const Text('查看结果'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // 主动获取焦点
                    FocusScope.of(context).requestFocus(_focusNode);
                  },
                  child: const Text('主动获取焦点'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // _controller.value = const TextEditingValue(
                    //   text: 'aaaaa',
                    // );
                    _controller.text = 'aaaaa';
                  },
                  child: const Text('主动设置值'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // _controller.selection =
                    //     const TextSelection(baseOffset: 1, extentOffset: 1);
                  },
                  child: const Text('主动选中'),
                ),
              ],
            ),
          )),
    );
  }
}
