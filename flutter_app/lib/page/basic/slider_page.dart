import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _sliderValue1 = 0.0;
  double _sliderValue2 = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Text('值为 $_sliderValue1 和 $_sliderValue2'),
          Slider(
            value: _sliderValue1,
            onChanged: (newValue) {
              setState(() {
                _sliderValue1 = newValue;
              });
            },
          ),
          Slider(
            value: _sliderValue2,
            // 值发生变更时触发，从手指按下到抬起期间可能会被调用多次，只要值发生变更就会被调用
            onChanged: (newValue) {
              debugPrint('onChanged $newValue');
              setState(() {
                _sliderValue2 = newValue;
              });
            },
            // 手指按下时触发一次（值没变更也会被调用），打印当前值
            onChangeStart: (value) => debugPrint('onChangeStart $value'),
            // 手指抬起时触发一次（值没变更也会被调用），打印最终的值
            onChangeEnd: (value) => debugPrint('onChangeEnd $value'),
            min: 0, // 最小值
            max: 10, // 最大值
            divisions: 5, // 分割成 5 份
            label: '${_sliderValue2.toInt()}',
            activeColor: Colors.red,
            inactiveColor: Colors.green,
            thumbColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
