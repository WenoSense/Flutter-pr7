import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../data/payment_repository.dart';
import '../models/payment.dart';
import 'payments_list_screen.dart';

class PaymentFormScreen extends StatefulWidget {
  const PaymentFormScreen({super.key});

  @override
  State<PaymentFormScreen> createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends State<PaymentFormScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  String _selectedPeriod = 'Ежемесячно';
  String _selectedCategory = 'Подписки';

  final List<String> _categories = [
    'Подписки',
    'Коммунальные услуги',
    'Аренда',
    'Кредиты',
    'Транспорт',
    'Связь',
    'Продукты',
    'Другое'
  ];

  void _submit() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0 || _dateController.text.isEmpty) return;

    try {
      final parsedDate = DateFormat('dd.MM.yyyy').parse(_dateController.text);
      final payment = Payment(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        amount: amount,
        category: _selectedCategory,
        nextDate: parsedDate,
        period: _selectedPeriod,
      );
      PaymentRepository.addPayment(payment);
    } catch (_) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить платёж'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Назад',
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Название платежа'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Сумма'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _selectedCategory = v!),
              decoration: const InputDecoration(labelText: 'Категория'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: 'Дата следующего платежа (ДД.ММ.ГГГГ)',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedPeriod,
              items: const [
                DropdownMenuItem(value: 'Еженедельно', child: Text('Еженедельно')),
                DropdownMenuItem(value: 'Ежемесячно', child: Text('Ежемесячно')),
                DropdownMenuItem(value: 'Ежегодно', child: Text('Ежегодно')),
              ],
              onChanged: (v) => setState(() => _selectedPeriod = v!),
              decoration: const InputDecoration(labelText: 'Периодичность'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _submit();
                context.go('/');
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
