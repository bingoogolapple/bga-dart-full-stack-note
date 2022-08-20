import 'package:flutter/material.dart';

class BGALogoWidget extends StatelessWidget {
  const BGALogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset('packages/bga_flutter_package/assets/images/BGA.png'),
    );
  }
}
