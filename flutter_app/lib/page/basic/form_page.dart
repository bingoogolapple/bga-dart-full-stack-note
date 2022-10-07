import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _controller = TextEditingController(text: 'BGA');
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();
  String? _password;
  String? _username;

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
        title: const Text('输入框'),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // 主动获取焦点
                    FocusScope.of(context).requestFocus(_focusNode);
                  },
                  child: const Text('主动获取焦点'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // initialValue 和 controller 只能存在一个
                  // initialValue: 'BGA',
                  controller: _controller,
                  // 允许的输入格式
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[1-31111111a-cBGA]'))
                  ],
                  // 内容改变时的回调
                  onChanged: (text) => debugPrint('onChanged：$text'),
                  // 在 onFieldSubmitted 之前被调用
                  onEditingComplete: () => debugPrint('onEditingComplete'),
                  // 按回车键时的回调
                  onFieldSubmitted: (text) =>
                      debugPrint('onFieldSubmitted：$text'),
                  // InputDecoration.collapsed 删除 TextField 上的默认下划线，内部是把 border 设置为 InputBorder.none
                  decoration: const InputDecoration.collapsed(hintText: '用户名'),
                  // decoration: const InputDecoration(labelText: '用户名'),
                  focusNode: _focusNode,
                  validator: (value) {
                    if (value != null && value.length < 3) {
                      // 校验不通过时返回提示文本
                      return '用户名长度不能小于3';
                    }
                    return null;
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
                  decoration: const InputDecoration(labelText: '密码'),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      var formState = _formKey.currentState;
                      if (formState == null) {
                        return;
                      }
                      if (formState.validate()) {
                        formState.save();
                        debugPrint(
                            '注册 username: $_username, password:$_password');
                      }
                    },
                    // color: Theme.of(context).accentColor,
                    // elevation: 0,
                    child: const Text(
                      '注册',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                    },
                    child: const Text(
                      '重置',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
