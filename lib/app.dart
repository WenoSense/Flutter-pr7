import 'package:flutter/material.dart';
import 'router.dart';
import 'shared/app_theme.dart';

class RegularPaymentsApp extends StatelessWidget {
  const RegularPaymentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Регулярные платежи',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
