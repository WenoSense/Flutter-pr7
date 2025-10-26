import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/payment_repository.dart';
import '../models/payment.dart';
import '../widgets/payment_card.dart';
import 'payment_form_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import 'about_developer_screen.dart';

enum SortOption { nearestDate, category, amount }

class PaymentsListScreen extends StatefulWidget {
  const PaymentsListScreen({super.key});

  @override
  State<PaymentsListScreen> createState() => _PaymentsListScreenState();
}

class _PaymentsListScreenState extends State<PaymentsListScreen> {
  List<Payment> get _payments => PaymentRepository.payments;

  SortOption _sortOption = SortOption.nearestDate;
  String _searchQuery = '';
  String _filterCategory = 'Все';

  void _markPaymentAsPaid(String id) {
    setState(() => PaymentRepository.markAsPaid(id));
  }

  void _deletePayment(String id) {
    setState(() => PaymentRepository.deletePayment(id));
  }

  void _toggleFavorite(Payment payment) {
    setState(() {
      payment.isFavorite = !payment.isFavorite;
    });
  }

  List<Payment> _getSortedPayments() {
    final now = DateTime.now();
    final sorted = List<Payment>.from(_payments);
    switch (_sortOption) {
      case SortOption.nearestDate:
        sorted.sort((a, b) => a.nextDate.difference(now).inDays.compareTo(b.nextDate.difference(now).inDays));
        break;
      case SortOption.category:
        sorted.sort((a, b) => a.category.compareTo(b.category));
        break;
      case SortOption.amount:
        sorted.sort((a, b) => a.amount.compareTo(b.amount));
        break;
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final paymentsList = _getSortedPayments();
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

    final filteredPayments = paymentsList.where((p) {
      final matchesSearch = p.title.toLowerCase().contains(_searchQuery);
      final matchesCategory = _filterCategory == 'Все' || p.category == _filterCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Регулярные платежи'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            tooltip: 'Избранное',
            onPressed: () => context.push('/favorites'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Настройки',
            onPressed: () => context.push('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'О разработчике',
            onPressed: () => context.push('/about'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
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
                  child: DropdownButtonFormField<String>(
                    value: _filterCategory,
                    items: categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => _filterCategory = v!),
                    decoration: const InputDecoration(labelText: 'Категория'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<SortOption>(
                    value: _sortOption,
                    items: const [
                      DropdownMenuItem(value: SortOption.nearestDate, child: Text('По дате')),
                      DropdownMenuItem(value: SortOption.category, child: Text('По категории')),
                      DropdownMenuItem(value: SortOption.amount, child: Text('По сумме')),
                    ],
                    onChanged: (v) => setState(() => _sortOption = v!),
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
                return PaymentCard(
                  payment: p,
                  onMarkPaid: _markPaymentAsPaid,
                  onDelete: _deletePayment,
                  onToggleFavorite: _toggleFavorite,
                  isFavorite: p.isFavorite,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Добавить платёж',
        onPressed: () => context.push('/add'),
      ),
    );
  }
}
