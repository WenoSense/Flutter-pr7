import 'package:flutter/material.dart';
import 'shared/app_theme.dart';
import 'router.dart';

class RegularPaymentsApp extends StatelessWidget {
  const RegularPaymentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Регулярные платежи',
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
