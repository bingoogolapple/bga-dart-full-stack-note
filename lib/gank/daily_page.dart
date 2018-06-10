import 'dart:async';
import 'package:flutter/material.dart';

typedef void OnClickSearch();

// 每日干货页面
class DailyPage extends StatefulWidget {
  static const String title = '每日干货';
  static const Color color = Colors.orange;

  final OnClickSearch onClickSearch;

  DailyPage({@required this.onClickSearch});

  @override
  createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: DailyPage.color,
        automaticallyImplyLeading: false,
        title: Text(DailyPage.title),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.today), onPressed: () => _selectDate(context)),
          new IconButton(icon: new Icon(Icons.search), onPressed: () => widget.onClickSearch())
        ],
      ),
      body: Center(
        child: Text(DailyPage.title),
      ),
    );
  }

//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: new DateTime(2015, 8), lastDate: DateTime.now());
//    if (picked == null) {
//      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("没有选择")));
//      return;
//    }
//    if (picked == _selectedDate) {
//      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("和之前的日期一样")));
//      return;
//    }
//    setState(() {
//      _selectedDate = picked;
//      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("选择了${_selectedDate.toString()}")));
//    });
//  }

  _selectDate(BuildContext context) {
    showDatePicker(context: context, initialDate: _selectedDate, firstDate: new DateTime(2015, 8), lastDate: DateTime.now()).then((picked) {
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
      }
    });
  }
}
