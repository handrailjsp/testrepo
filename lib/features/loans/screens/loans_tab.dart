import 'package:flutter/material.dart';
import 'loans_screen.dart';

class LoansTab extends StatelessWidget {
  const LoansTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is just a wrapper to integrate with the dashboard
    return const LoansScreen();
  }
}
