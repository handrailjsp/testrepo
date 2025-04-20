import 'package:flutter/material.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String bankTransfer = '/bank-transfer';
  static const String payment = '/payment';
  static const String receiveMoney = '/receive-money';
  static const String topup = '/topup';
  static const String transactionDetails = '/transaction-details';
  static const String transactionHistory = '/transaction-history';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      dashboard: (context) => const DashboardScreen(),
    };
  }
}

// Placeholder class to fix compilation
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Dashboard Screen'),
      ),
    );
  }
}