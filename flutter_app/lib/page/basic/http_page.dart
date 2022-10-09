import 'package:flutter/material.dart';
import 'package:flutter_app/widget/http_client_widget.dart';
import 'package:flutter_app/widget/http_server_widget.dart';

class HttpPage extends StatelessWidget {
  const HttpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP')),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(flex: 2, child: HttpServerWidget()),
          Expanded(flex: 3, child: HttpClientWidget()),
        ],
      ),
    );
  }
}
