import 'package:flutter/material.dart';
import 'common.dart';

class AppBarActionsApp extends StatefulWidget {
  @override
  createState() => new _AppBarActionsAppStage();
}

class _AppBarActionsAppStage extends State<AppBarActionsApp> {
  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    setState(() {
      // Causes the app to rebuild with the new _selectedChoice.
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBarActionsApp'),
        actions: <Widget>[
          new IconButton(
            // action button
            icon: new Icon(choices[0].icon),
            onPressed: () {
              _select(choices[0]);
            },
          ),
          new IconButton(
            // action button
            icon: new Icon(choices[1].icon),
            onPressed: () {
              _select(choices[1]);
            },
          ),
          new PopupMenuButton<Choice>(
            // overflow menu
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.skip(2).map((Choice choice) {
                return new PopupMenuItem<Choice>(
                  value: choice,
                  child: new Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new ChoiceCard(choice: _selectedChoice),
      ),
    );
  }
}
