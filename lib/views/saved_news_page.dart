import 'package:flutter/material.dart';

class SavedNewsPage extends StatelessWidget {
  const SavedNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
      ),
      body: const Center(
        child: Text('Display your saved news here'),
      ),
    );
  }
}
