import 'package:flutter/material.dart';
import 'common.dart';

class AppBarIndicatorApp extends StatefulWidget {
  @override
  createState() => new _AppBarIndicatorAppStage();
}

class _AppBarIndicatorAppStage extends State<AppBarIndicatorApp>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: choices.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBarIndicatorApp'),
        leading: new IconButton(
          tooltip: 'Previous choice',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _nextPage(-1);
          },
        ),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Next choice',
            onPressed: () {
              _nextPage(1);
            },
          ),
        ],
        bottom: new PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: new Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: new Container(
              height: 48.0,
              alignment: Alignment.center,
              child: new TabPageSelector(controller: _tabController),
            ),
          ),
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: choices.map((Choice choice) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new ChoiceCard(choice: choice),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
