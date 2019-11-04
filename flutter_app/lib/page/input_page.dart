import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InputPageState();
  }
}

class _InputPageState extends State<InputPage> {
  final _controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();
  String _password;
  String _username;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller
        .addListener(() => debugPrint('_controller：${_controller.text}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('输入框'),
      ),
      body: ListView(
        children: <Widget>[
          // TextField 组件没有像 Android 中那样的 ID，无法通过实例根据需要检索文本，而必须在更改时将其存储在变量中或使用控制器
          TextField(
            decoration: InputDecoration(
              // 展示在 border 外面
              icon: Icon(Icons.account_circle),
              // 没有输入内容且未聚焦时的提示文案，聚焦时的浮动提示文案
              labelText: 'labelText',
              // errorText 为空时会一直展示 helperText
              helperText: 'helperText',
              // 聚焦且没有输入内容时才会展示
              hintText: 'hintText',
              // 只要不为 null，就会展示
//                errorText: 'errorText',
              // 聚焦时是否展示浮动的 labelText，默认为 false
              hasFloatingPlaceholder: true,
              // 是否密集，默认为 false，子控件是否暂用更少的空间
              isDense: true,
              contentPadding: EdgeInsets.all(20),
              /**
               * 只有聚焦或者有值时才会展示 prefix、prefixText、suffix、suffixText
               */
              prefixIcon: Icon(Icons.add_call),
              // 和 prefixText 只能存在一个
//              prefix: Text('prefix'),
              prefixText: 'prefixText',
              suffixIcon: Icon(Icons.add),
              // 和 suffixText 只能存在一个
//              suffix: Text('suffix'),
              suffixText: 'suffixText',
              // 右下角用于展示计数的文本，设置之后右下角是固定字符串，不会有一个输入数量的统计字符串
//              counterText: 'counterText',
              // 填充除了 border 和 icon 以外的其他区域
              filled: true,
              fillColor: Colors.lightGreen,
              errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 20,
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: Colors.deepPurple,
                  width: 20,
                  style: BorderStyle.solid,
                ),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: Colors.orange,
                  width: 20,
                  style: BorderStyle.solid,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: Colors.teal,
                  width: 10,
                  style: BorderStyle.none,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.brown,
                  width: 10,
                  style: BorderStyle.none,
                ),
              ),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: Colors.yellow,
                  width: 10,
                  style: BorderStyle.none,
                ),
              ),
              enabled: true,
              // TODO?
              semanticCounterText: 'semanticCounterText',
            ),
            // 获取内容、赋值、添加监听等
            controller: _controller,
            // 内容改变时的回调
            onChanged: (text) => debugPrint('onChanged：$text'),
            // 按回车键时的回调
            onSubmitted: (text) => debugPrint('onSubmitted：$text'),
            // 密码输入
            obscureText: false,
            // 最大行数。默认情况下，将 maxLines 设置为直接值会将其自动扩展为该行数；设置成 null 的话当一行完成时会自动扩展
            maxLines: 1,
            // 自动获取焦点
            autofocus: true,
            // 输入文本的样式
            style: TextStyle(fontSize: 20, color: Colors.red),
            // 没有设置 counterText 且设置了 maxLength 之后右下角会有一个输入数量的统计字符串
            maxLength: 10,
            // 允许的输入格式
//            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            // 键盘类型
            keyboardType: TextInputType.text,
            // 替换右下角 Done 按钮
            textInputAction: TextInputAction.continueAction,
            // 文本对齐方式
            textAlign: TextAlign.center,
            // sentences 每个句子的首字母大写，characters 所有字符大写，words 每个单词首字母大写
            textCapitalization: TextCapitalization.words,
            // 修改光标样式
            cursorColor: Colors.red,
            cursorRadius: Radius.circular(8),
            cursorWidth: 16,
          ),
          RaisedButton(
            onPressed: () {
              debugPrint('结果为：${_controller.text}');
              // 主动获取焦点
              FocusScope.of(context).requestFocus(_focusNode);
            },
            child: Text('查看结果'),
          ),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  // InputDecoration.collapsed 删除 TextField 上的默认下划线，内部是把 border 设置为 InputBorder.none
                  decoration: InputDecoration.collapsed(hintText: '用户名'),
//                  decoration: InputDecoration(labelText: '用户名'),
                  focusNode: _focusNode,
                  initialValue: 'BGA',
                  // 校验不通过时自动展示错误信息
                  autovalidate: true,
                  validator: (value) {
                    if (value.length < 3) {
                      // 校验不通过时返回提示文本
                      return '用户名长度不能小于3';
                    }
                  },
                  onSaved: (username) {
                    debugPrint('onSaved username：$username');
                    _username = username;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  onSaved: (password) {
                    debugPrint('onSaved password：$password');
                    _password = password;
                  },
                  decoration: InputDecoration(labelText: '密码'),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      _formKey.currentState.save();
                      if (_formKey.currentState.validate()) {
                        debugPrint('注册');
                      }
                    },
                    color: Theme.of(context).accentColor,
                    elevation: 0,
                    child: Text(
                      '注册',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
