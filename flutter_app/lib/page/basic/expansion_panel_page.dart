import 'package:flutter/material.dart';

class ExpansionPanelItem {
  final String headerText;
  final Widget body;
  bool isExpanded;

  ExpansionPanelItem({
    required this.headerText,
    required this.body,
    required this.isExpanded,
  });
}

class ExpansionPanelPage extends StatefulWidget {
  const ExpansionPanelPage({super.key});

  @override
  State<ExpansionPanelPage> createState() => _ExpansionPanelPageState();
}

class _ExpansionPanelPageState extends State<ExpansionPanelPage> {
  late List<ExpansionPanelItem> _expansionPanelItems;

  @override
  void initState() {
    super.initState();
    _expansionPanelItems = <ExpansionPanelItem>[
      ExpansionPanelItem(
        headerText: '面板 A',
        body: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: const Text('我是面板 A 的内容'),
        ),
        isExpanded: false,
      ),
      ExpansionPanelItem(
        headerText: '面板 B',
        body: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: const Text('我是面板 B 的内容'),
        ),
        isExpanded: false,
      ),
      ExpansionPanelItem(
        headerText: '面板 C',
        body: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: const Text('我是面板 C 的内容'),
        ),
        isExpanded: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpansionPanel'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          ExpansionPanelList(
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                _expansionPanelItems[panelIndex].isExpanded = !isExpanded;
              });
            },
            dividerColor: Colors.red,
            children: _expansionPanelItems.map((ExpansionPanelItem item) {
              return ExpansionPanel(
                isExpanded: item.isExpanded,
                body: item.body,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      item.headerText,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
