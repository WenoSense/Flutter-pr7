import 'package:flutter/material.dart';
import '../models/payment.dart';
import 'package:intl/intl.dart';

class PaymentCard extends StatelessWidget {
  final Payment payment;
  final ValueChanged<String> onMarkPaid;
  final ValueChanged<String> onDelete;
  final ValueChanged<Payment>? onToggleFavorite;
  final bool isFavorite;

  const PaymentCard({
    super.key,
    required this.payment,
    required this.onMarkPaid,
    required this.onDelete,
    this.onToggleFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd.MM.yyyy');

    return Dismissible(
      key: ValueKey(payment.id),
      onDismissed: (_) => onDelete(payment.id),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          title: Text('${payment.title} (${payment.category})'),
          subtitle: Text(
            'Сумма: ${payment.amount}₽\n'
                'Следующий платёж: ${formatter.format(payment.nextDate)}\n'
                '${payment.period}',
          ),
          trailing: Wrap(
            spacing: 4,
            children: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.amber : Colors.grey,
                ),
                tooltip: isFavorite ? 'Убрать из избранного' : 'Добавить в избранное',
                onPressed: () => onToggleFavorite?.call(payment),
              ),
              IconButton(
                icon: const Icon(Icons.check_circle_outline),
                onPressed: () => onMarkPaid(payment.id),
                tooltip: 'Отметить как оплачено',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
