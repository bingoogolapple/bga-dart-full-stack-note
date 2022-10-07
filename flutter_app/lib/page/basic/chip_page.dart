import 'package:flutter/material.dart';

class ChipPage extends StatefulWidget {
  const ChipPage({super.key});

  @override
  State<ChipPage> createState() => _ChipPageState();
}

class _ChipPageState extends State<ChipPage> {
  List<String> _tags = [
    '苹果',
    '香蕉',
    '柠檬',
  ];

  String _actionChip = '未选择';
  List<String> _filterChip = [];
  String _choiceChip = '柠檬';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chip'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              const Chip(
                label: Text('默认'),
              ),
              const Chip(
                label: Text('背景色'),
                backgroundColor: Colors.orange,
              ),
              const Chip(
                label: Text('文本头像'),
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text('A'),
                ),
              ),
              const Chip(
                label: Text('图片头像'),
                avatar: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/8949716?v=4'),
                ),
              ),
              Chip(
                label: const Text('删除'),
                onDeleted: () {},
                deleteIcon: const Icon(Icons.delete),
                deleteButtonTooltipMessage: '删除当前标签',
              ),
              const Divider(
                color: Colors.red,
                height: 32,
                thickness: 8,
                indent: 16,
                endIndent: 16,
              ),
              Wrap(
                spacing: 8,
                children: _tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () {
                      setState(() {
                        _tags.remove(tag);
                      });
                    },
                    deleteButtonTooltipMessage: '',
                  );
                }).toList(),
              ),
              const Divider(
                color: Colors.grey,
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text('ActionChip: $_actionChip'),
              ),
              Wrap(
                spacing: 8,
                children: _tags.map((tag) {
                  return ActionChip(
                    label: Text(tag),
                    onPressed: () {
                      setState(() {
                        _actionChip = tag;
                      });
                    },
                  );
                }).toList(),
              ),
              const Divider(
                color: Colors.grey,
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text('FilterChip: ${_filterChip.toString()}'),
              ),
              Wrap(
                spacing: 8,
                children: _tags.map((tag) {
                  return FilterChip(
                    label: Text(tag),
                    selected: _filterChip.contains(tag),
                    selectedColor: Colors.purple,
                    onSelected: (value) {
                      setState(() {
                        if (_filterChip.contains(tag)) {
                          _filterChip.remove(tag);
                        } else {
                          _filterChip.add(tag);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const Divider(
                color: Colors.grey,
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text('ChoiceChip: $_choiceChip'),
              ),
              Wrap(
                spacing: 8,
                children: _tags.map((tag) {
                  return ChoiceChip(
                    label: Text(tag),
                    selectedColor: Colors.purple,
                    selected: _choiceChip == tag,
                    onSelected: (value) {
                      setState(() {
                        _choiceChip = tag;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.restore),
        onPressed: () {
          setState(() {
            _tags = [
              '苹果',
              '香蕉',
              '柠檬',
            ];
            _filterChip = [];
            _choiceChip = '柠檬';
          });
        },
      ),
    );
  }
}
