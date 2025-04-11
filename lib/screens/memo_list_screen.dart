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
                return Dismissible(
                  key: Key(memo.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    final bool? shouldDelete = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('메모 삭제'),
                        content: const Text('정말로 이 메모를 삭제하시겠습니까?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('취소'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('삭제'),
                          ),
                        ],
                      ),
                    );
                    return shouldDelete ?? false;
                  },
                  onDismissed: (direction) async {
                    if (memo.id != null) {
                      await _dbHelper.deleteMemo(memo.id!);
                      setState(() {
                        _memos.removeAt(index);
                      });
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('메모가 삭제되었습니다.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  child: Card(
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
                        ).then((_) => _loadMemos());
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
