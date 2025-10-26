import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'На главный экран',
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(
        child: Text(
          'Раздел настроек пока пуст',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
