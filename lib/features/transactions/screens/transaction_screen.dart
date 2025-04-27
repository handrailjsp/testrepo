import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import 'transaction_details_screen.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1535),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1535),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          },
        ),
        title: const Text(
          'Transactions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'As of Oct 15, 2023',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildTransactionItem(
                  context,
                  title: 'Merchant Name',
                  date: '15 Oct 2023',
                  amount: '- ₱ 40.00',
                  isExpense: true,
                ),
                _buildTransactionItem(
                  context,
                  title: 'Merchant Name',
                  date: '10 Oct 2023',
                  amount: '- ₱ 218.00',
                  isExpense: true,
                ),
                _buildTransactionItem(
                  context,
                  title: 'Receive Transfer',
                  date: '10 Oct 2023',
                  amount: '+ ₱ 260.00',
                  isExpense: false,
                ),
                _buildTransactionItem(
                  context,
                  title: 'Merchant Name',
                  date: '8 Oct 2023',
                  amount: '- ₱ 110.00',
                  isExpense: true,
                ),
                _buildTransactionItem(
                  context,
                  title: 'Merchant Name',
                  date: '8 Oct 2023',
                  amount: '- ₱ 20.00',
                  isExpense: true,
                ),
                _buildTransactionItem(
                  context,
                  title: 'Receive Transfer',
                  date: '8 Oct 2023',
                  amount: '+ ₱ 600.00',
                  isExpense: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
      BuildContext context, {
        required String title,
        required String date,
        required String amount,
        required bool isExpense,
      }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailsScreen(
              title: title,
              subtitle: 'Transaction details',
              amount: amount,
              date: date,
              icon: isExpense ? Icons.arrow_downward : Icons.arrow_upward,
              isExpense: isExpense,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2250),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF2D3A7A),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isExpense ? Icons.arrow_downward : Icons.arrow_upward,
                color: isExpense ? Colors.red : Colors.green,
                size: 18,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                color: isExpense ? Colors.red : Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}