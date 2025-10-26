import 'package:flutter/material.dart';
import 'features/payments/screens/payments_list_screen.dart';
import 'shared/app_theme.dart';

class RegularPaymentsApp extends StatelessWidget {
  const RegularPaymentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Регулярные платежи',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const PaymentsListScreen(),
    );
  }
}
