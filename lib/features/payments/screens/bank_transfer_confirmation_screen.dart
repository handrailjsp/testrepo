import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';

class BankTransferConfirmationScreen extends StatelessWidget {
  final String bankName;
  final double amount;
  final String accountName;
  final String accountNumber;
  final String email;

  const BankTransferConfirmationScreen({
    Key? key,
    required this.bankName,
    required this.amount,
    required this.accountName,
    required this.accountNumber,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Done'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              'Bank Transfer is being Processed',
              style: TextStyles.subtitle1.copyWith(
                color: AppColors.primaryBlue,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Sent via Cha-Ching',
              style: TextStyles.body2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'We\'ll send updates to your Cha-Ching inbox within an hour. Successful transactions will be instantly credited.',
              style: TextStyles.body2,
              textAlign: TextAlign.center,
            ),
            Text(
              'If the recipient states pending bank validation, your bank may take 1 to 5 business days to process.',
              style: TextStyles.body2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildTransferDetails(),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cardBackground,
                    ),
                    child: const Text('DOWNLOAD'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cardBackground,
                    ),
                    child: const Text('SHARE'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow('Bank', bankName),
          _buildDetailRow('Account No.', accountNumber),
          _buildDetailRow('Account No.', accountName),
          _buildDetailRow('Receipt sent to', email),
          _buildDetailRow('Transfer Date', 'April 14, 2023 10:31 PM'),
          _buildDetailRow('Transfer Amount', '₱${amount.toStringAsFixed(2)}'),
          _buildDetailRow('+Fee', '20.00'),
          const Divider(color: Colors.grey),
          _buildDetailRow('Total', '₱${(amount + 20).toStringAsFixed(2)}', isBold: true),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildDetailRow('InstaPay Invoice No.', '600323', isSmall: true),
                _buildDetailRow('Ref No.', '1678456977234561', isSmall: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false, bool isSmall = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isSmall
                ? const TextStyle(fontSize: 12, color: Colors.black54)
                : const TextStyle(fontSize: 14, color: Colors.black),
          ),
          Text(
            value,
            style: isSmall
                ? const TextStyle(fontSize: 12, color: Colors.black)
                : TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}