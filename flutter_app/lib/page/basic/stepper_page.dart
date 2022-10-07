import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stepper'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepTapped: (int value) {
          setState(() {
            _currentStep = value;
          });
        },
        onStepContinue: () {
          setState(() {
            _currentStep < 2 ? _currentStep += 1 : _currentStep = 0;
          });
        },
        onStepCancel: () {
          setState(() {
            _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
          });
        },
        type: StepperType.horizontal,
        elevation: 10,
        steps: [
          Step(
            title: const Text('第一步 title'),
            subtitle: const Text('第一步 subtitle'),
            content: const Text('第一步 content'),
            // 仅 horizontal 时 label 生效
            // label: const Text('第一步 label'),
            isActive: _currentStep == 0,
          ),
          Step(
            title: const Text('第二步 title'),
            subtitle: const Text('第二步 subtitle'),
            content: const Text('第二步 content'),
            label: const Text('第二步 label'),
            isActive: _currentStep == 1,
          ),
          Step(
            title: const Text('第三步 title'),
            subtitle: const Text('第三步 subtitle'),
            content: const Text('第三步 content'),
            label: const Text('第三步 label'),
            isActive: _currentStep == 2,
          ),
        ],
      ),
    );
  }
}
