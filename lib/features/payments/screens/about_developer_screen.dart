import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О разработчике'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'На главный экран',
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Разработчик приложения',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 16),
            Text(
              'Имя: Кирилл Соломатин\n'
                  'Email: solomatin.k.a@edu.mirea.ru\n\n',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
