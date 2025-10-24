import 'package:flutter/material.dart';
import '../models/payment.dart';
import '../state/payments_container.dart';
import '../widgets/payment_card.dart';

class PaymentsListScreen extends StatelessWidget {
  final List<Payment> payments;
  final ValueChanged<String> onMarkPaid;
  final ValueChanged<String> onDelete;
  final ValueChanged<SortOption> onSort;
  final SortOption sortOption;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final String selectedCategory;
  final ValueChanged<String> onCategoryFilterChanged;
  final List<Payment> favorites;
  final ValueChanged<Payment> onToggleFavorite;

  const PaymentsListScreen({
    super.key,
    required this.payments,
    required this.onMarkPaid,
    required this.onDelete,
    required this.onSort,
    required this.sortOption,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.selectedCategory,
    required this.onCategoryFilterChanged,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Все',
      'Подписки',
      'Коммунальные услуги',
      'Аренда',
      'Кредиты',
      'Транспорт',
      'Связь',
      'Продукты',
      'Другое'
    ];

    final filteredPayments = payments.where((p) {
      final matchesSearch = p.title.toLowerCase().contains(searchQuery);
      final matchesCategory = selectedCategory == 'Все' || p.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Регулярные платежи'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                labelText: 'Поиск по названию',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items: categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => onCategoryFilterChanged(v!),
                    decoration: const InputDecoration(labelText: 'Категория'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<SortOption>(
                    value: sortOption,
                    items: const [
                      DropdownMenuItem(
                        value: SortOption.nearestDate,
                        child: Text('По дате'),
                      ),
                      DropdownMenuItem(
                        value: SortOption.category,
                        child: Text('По категории'),
                      ),
                      DropdownMenuItem(
                        value: SortOption.amount,
                        child: Text('По сумме'),
                      ),
                    ],
                    onChanged: (v) => onSort(v!),
                    decoration: const InputDecoration(labelText: 'Сортировка'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredPayments.isEmpty
                ? const Center(child: Text('Нет платежей'))
                : ListView.builder(
              itemCount: filteredPayments.length,
              itemBuilder: (context, index) {
                final p = filteredPayments[index];
                final isFavorite = favorites.any((f) => f.id == p.id);

                return PaymentCard(
                  payment: p,
                  onMarkPaid: onMarkPaid,
                  onDelete: onDelete,
                  onToggleFavorite: onToggleFavorite,
                  isFavorite: isFavorite,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
