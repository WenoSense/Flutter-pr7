import 'package:flutter/material.dart';
import '../../../data/payment_repository.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = PaymentRepository.payments.where((p) => p.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранные платежи'),
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
              trailing: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
          );
        },
      ),
    );
  }
}
