import 'package:flutter/material.dart';
import 'package:memo_app/database/database_helper.dart';
import 'package:memo_app/models/memo.dart';

class MemoAddScreen extends StatefulWidget {
  const MemoAddScreen({super.key});

  @override
  State<MemoAddScreen> createState() => _MemoAddScreenState();
}

class _MemoAddScreenState extends State<MemoAddScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _dbHelper = DatabaseHelper();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveMemo() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목과 내용을 모두 입력해주세요.')),
      );
      return;
    }

    final memo = Memo(
      title: _titleController.text,
      content: _contentController.text,
      createdAt: DateTime.now(),
    );

    await _dbHelper.insertMemo(memo.toMap());
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 메모'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveMemo,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
