import 'package:flutter/material.dart';
import 'package:memo_app/database/database_helper.dart';
import 'package:memo_app/models/memo.dart';
import 'package:memo_app/screens/memo_detail_screen.dart';

class MemoSearchScreen extends StatefulWidget {
  final String searchQuery;

  const MemoSearchScreen({super.key, required this.searchQuery});

  @override
  State<MemoSearchScreen> createState() => _MemoSearchScreenState();
}

class _MemoSearchScreenState extends State<MemoSearchScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Memo> _filteredMemos = [];

  @override
  void initState() {
    super.initState();
    _loadFilteredMemos();
  }

  Future<void> _loadFilteredMemos() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getMemos();
    setState(() {
      _filteredMemos = maps
          .map((map) => Memo.fromMap(map))
          .where((memo) =>
              memo.title
                  .toLowerCase()
                  .contains(widget.searchQuery.toLowerCase()) ||
              memo.content
                  .toLowerCase()
                  .contains(widget.searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('"${widget.searchQuery}" 검색 결과'),
      ),
      body: _filteredMemos.isEmpty
          ? const Center(
              child: Text('검색 결과가 없습니다.'),
            )
          : ListView.builder(
              itemCount: _filteredMemos.length,
              itemBuilder: (context, index) {
                final memo = _filteredMemos[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(memo.title),
                    subtitle: Text(
                      memo.createdAt.toString().split('.').first,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MemoDetailScreen(memo: memo),
                        ),
                      ).then((_) => _loadFilteredMemos());
                    },
                  ),
                );
              },
            ),
    );
  }
}
