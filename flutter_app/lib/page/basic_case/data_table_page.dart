import 'package:flutter/material.dart';
import 'package:flutter_app/mock/net_images.dart';

class Post {
  final String title;
  final String author;
  final String imageUrl;
  final String description;
  bool? selected = false;

  Post({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
  });
}

final List<Post> posts = NET_IMAGES
    .map((imgUrl) => Post(
          title: '标题',
          author: '作者',
          description: '描述',
          imageUrl: imgUrl,
        ))
    .toList();

class DataTablePage extends StatefulWidget {
  const DataTablePage({super.key});

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataTable'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          onSelectAll: ((bool? value) {
            debugPrint('onSelectAll: $value');
            setState(() {
              for (var element in posts) {
                element.selected = value;
              }
            });
          }),
          columns: [
            DataColumn(
              label: const Text('列1'),
              tooltip: '列1提示',
              onSort: (int index, bool ascending) {
                setState(() {
                  setState(() {
                    posts.sort((a, b) {
                      if (!ascending) {
                        final c = a;
                        a = b;
                        b = c;
                      }

                      return a.title.length.compareTo(b.title.length);
                    });
                    _sortColumnIndex = index;
                    _sortAscending = ascending;
                  });
                });
              },
            ),
            const DataColumn(
              label: Text('列2'),
            ),
            const DataColumn(
              label: Text('列3'),
            ),
          ],
          rows: posts.map((post) {
            return DataRow(
                selected: post.selected ?? false,
                color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.purple;
                  }
                  return null;
                }),
                onSelectChanged: (bool? value) {
                  setState(() {
                    post.selected = value;
                  });
                },
                onLongPress: () {
                  debugPrint('onLongPress DataRow');
                },
                cells: [
                  DataCell(
                    Text(post.title),
                    showEditIcon: true,
                    placeholder: true,
                    onTap: () {
                      debugPrint('onTap DataCell');
                    },
                    onLongPress: () {
                      debugPrint('onLongPress DataCell');
                    },
                  ),
                  DataCell(Text(post.author)),
                  DataCell(Image.network(post.imageUrl)),
                ]);
          }).toList(),
        ),
      ),
    );
  }
}
