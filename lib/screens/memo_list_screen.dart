import 'package:flutter/material.dart';
import 'package:memo_app/database/database_helper.dart';
import 'package:memo_app/models/memo.dart';
import 'package:memo_app/screens/memo_add_screen.dart';
import 'package:memo_app/screens/memo_detail_screen.dart';

class MemoListScreen extends StatefulWidget {
  const MemoListScreen({super.key});

  @override
  State<MemoListScreen> createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Memo> _memos = [];

  @override
  void initState() {
    super.initState();
    _loadMemos();
  }

  Future<void> _loadMemos() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getMemos();
    setState(() {
      _memos = maps.map((map) => Memo.fromMap(map)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모장'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MemoAddScreen()),
              );
              _loadMemos();
            },
          ),
        ],
      ),
      body: _memos.isEmpty
          ? const Center(
              child: Text('메모가 없습니다.'),
            )
          : ListView.builder(
              itemCount: _memos.length,
              itemBuilder: (context, index) {
                final memo = _memos[index];
                return ListTile(
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
                    ).then((_) => _loadMemos());
                  },
                );
              },
            ),
    );
  }
}
