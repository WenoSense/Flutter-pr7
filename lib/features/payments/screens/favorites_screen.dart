import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/payment.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = (GoRouterState.of(context).extra as Map)['favorites'] as List<Payment>;
    final onDelete = (GoRouterState.of(context).extra as Map)['onDelete'] as ValueChanged<String>;
    final onUnfavorite = (GoRouterState.of(context).extra as Map)['onUnfavorite'] as ValueChanged<Payment>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранные платежи'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Назад',
          onPressed: () => context.pop(),
        ),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('Нет избранных платежей'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final payment = favorites[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text('${payment.title} (${payment.category})'),
              subtitle: Text('Сумма: ${payment.amount}₽'),
              trailing: IconButton(
                icon: const Icon(Icons.star, color: Colors.amber),
                tooltip: 'Удалить из избранного',
                onPressed: () => onUnfavorite(payment),
              ),
              onLongPress: () => onDelete(payment.id),
            ),
          );
        },
      ),
    );
  }
}
