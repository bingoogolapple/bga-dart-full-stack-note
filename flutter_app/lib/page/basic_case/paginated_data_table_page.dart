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

class PostDataSource extends DataTableSource {
  final List<Post> _posts = posts;
  int _selectedCount = 0;

  @override
  int get rowCount => _posts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  @override
  DataRow getRow(int index) {
    final Post post = _posts[index];

    return DataRow.byIndex(
      index: index,
      selected: post.selected ?? false,
      onSelectChanged: (bool? value) {
        // setState(() {
        //   post.selected = value;
        // });
      },
      cells: <DataCell>[
        DataCell(Text(post.title)),
        DataCell(Text(post.author)),
        DataCell(Image.network(post.imageUrl)),
      ],
    );
  }

  void _sort(getField(post), bool ascending) {
    _posts.sort((a, b) {
      if (!ascending) {
        final c = a;
        a = b;
        b = c;
      }

      final aValue = getField(a);
      final bValue = getField(b);

      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }
}

class PaginatedDataTablePage extends StatefulWidget {
  const PaginatedDataTablePage({super.key});

  @override
  State<PaginatedDataTablePage> createState() => _PaginatedDataTablePageState();
}

class _PaginatedDataTablePageState extends State<PaginatedDataTablePage> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  final PostDataSource _postsDataSource = PostDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaginatedDataTable'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          header: const Text('分页表格'),
          rowsPerPage: 5,
          actions: [
            ElevatedButton(
              onPressed: () => {},
              child: const Text('动作'),
            )
          ],
          source: _postsDataSource,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          // onSelectAll: ((bool? value) {
          //   debugPrint('onSelectAll: $value');
          //   setState(() {
          //     for (var element in posts) {
          //       element.selected = value;
          //     }
          //   });
          // }),
          columns: [
            DataColumn(
              label: const Text('列1'),
              onSort: (int columnIndex, bool ascending) {
                _postsDataSource._sort((post) => post.title.length, ascending);

                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = ascending;
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
        ),
      ),
    );
  }
}
