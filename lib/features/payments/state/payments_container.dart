import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/payment.dart';
import '../screens/payments_list_screen.dart';
import '../screens/payment_form_screen.dart';

enum SortOption { nearestDate, category, amount }

class PaymentsContainer extends StatefulWidget {
  const PaymentsContainer({super.key});

  @override
  State<PaymentsContainer> createState() => _PaymentsContainerState();
}

class _PaymentsContainerState extends State<PaymentsContainer> {
  final List<Payment> _payments = [];
  final List<Payment> _favoritePayments = [];

  SortOption _sortOption = SortOption.nearestDate;
  String _searchQuery = '';
  String _filterCategory = 'Все';

  void _addPayment(String title, double amount, String category, DateTime date, String period) {
    final newPayment = Payment(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: category,
      nextDate: date,
      period: period,
    );
    setState(() => _payments.add(newPayment));
  }

  void _markPaymentAsPaid(String id) {
    setState(() {
      final index = _payments.indexWhere((p) => p.id == id);
      if (index != -1) {
        _payments[index].nextDate = _payments[index].updatedNextDate;
      }
    });
  }

  void _deletePayment(String id) {
    setState(() => _payments.removeWhere((p) => p.id == id));
  }

  void _toggleFavorite(Payment payment) {
    setState(() {
      if (_favoritePayments.contains(payment)) {
        _favoritePayments.remove(payment);
      } else {
        _favoritePayments.add(payment);
      }
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Регулярные платежи'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            tooltip: 'Избранное',
            onPressed: () {
              context.push(
                '/favorites',
                extra: {
                  'favorites': _favoritePayments,
                  'onDelete': _deletePayment,
                  'onUnfavorite': _toggleFavorite,
                },
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Настройки',
            onPressed: () => context.go('/settings'),
          ),

          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'О разработчике',
            onPressed: () => context.pushReplacement('/about'),
          ),
        ],
      ),

      body: PaymentsListScreen(
        payments: paymentsList,
        onMarkPaid: _markPaymentAsPaid,
        onDelete: _deletePayment,
        onSort: (s) => setState(() => _sortOption = s),
        sortOption: _sortOption,
        searchQuery: _searchQuery,
        onSearchChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
        selectedCategory: _filterCategory,
        onCategoryFilterChanged: (v) => setState(() => _filterCategory = v),
        onToggleFavorite: _toggleFavorite,
        favorites: _favoritePayments,
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Добавить платёж',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PaymentFormScreen(onSave: _addPayment),
            ),
          );
        },
      ),
    );
  }
}
