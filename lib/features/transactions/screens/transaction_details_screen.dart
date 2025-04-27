import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final IconData icon;
  final bool isExpense;

  const TransactionDetailsScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.icon,
    required this.isExpense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Parse the amount string to get the numeric value
    final amountValue = double.tryParse(
        amount.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    final Map<String, dynamic> transaction = {
      'id': 'TX${DateTime.now().millisecondsSinceEpoch}',
      'title': title,
      'amount': amountValue,
      'isExpense': isExpense,
      'date': date,
      'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      'category': isExpense ? 'Purchase' : 'Transfer',
      'paymentMethod': 'Credit Card (**** 4567)',
      'status': 'Completed',
      'description': subtitle,
      'recipient': title,
    };

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Transaction Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransactionHeader(transaction),
            const SizedBox(height: 24),
            _buildTransactionDetails(transaction),
            const SizedBox(height: 32),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionHeader(Map<String, dynamic> transaction) {
    final isExpense = transaction['isExpense'] as bool;
    final amount = transaction['amount'] as double;
    final formattedAmount = '${isExpense ? '-' : '+'} ₱ ${amount.toStringAsFixed(2)}';

    return Center(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              color: isExpense ? AppColors.error : AppColors.success,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyles.subtitle1,
          ),
          const SizedBox(height: 8),
          Text(
            formattedAmount,
            style: TextStyles.amount.copyWith(
              color: isExpense ? AppColors.error : AppColors.success,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${transaction['date']} at ${transaction['time']}',
            style: TextStyles.caption,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(Map<String, dynamic> transaction) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildDetailRow('Transaction ID', transaction['id']),
          _buildDetailRow('Category', transaction['category']),
          _buildDetailRow('Payment Method', transaction['paymentMethod']),
          _buildDetailRow('Status', transaction['status']),
          _buildDetailRow('Recipient', transaction['recipient']),
          _buildDetailRow('Description', transaction['description']),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyles.body2.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          Text(
            value,
            style: TextStyles.body2,
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Download Receipt feature coming soon')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text('Download Receipt'),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Report Issue feature coming soon')),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textWhite,
            side: const BorderSide(color: AppColors.textGrey),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text('Report an Issue'),
        ),
      ],
    );
  }
}