import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import 'bank_transfer_confirmation_screen.dart';

class BankTransferDetailScreen extends StatefulWidget {
  final String bankName;

  const BankTransferDetailScreen({
    Key? key,
    required this.bankName,
  }) : super(key: key);

  @override
  State<BankTransferDetailScreen> createState() => _BankTransferDetailScreenState();
}

class _BankTransferDetailScreenState extends State<BankTransferDetailScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Bank Transfer'),
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
            _buildBankInfo(),
            const SizedBox(height: 24),
            _buildTransferForm(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _processTransfer,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Send Money'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankInfo() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Logo of bank',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          widget.bankName,
          style: TextStyles.subtitle1,
        ),
      ],
    );
  }

  Widget _buildTransferForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: TextStyles.body2.copyWith(
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '₱',
              style: TextStyles.body1,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: TextStyles.body1,
                decoration: const InputDecoration(
                  hintText: '0.00',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        Text(
          '(Max of PHP 50,000)',
          style: TextStyles.caption,
        ),
        Text(
          'Available balance: PHP 9999.99',
          style: TextStyles.caption,
        ),
        const SizedBox(height: 24),
        Text(
          'Account Name',
          style: TextStyles.body2.copyWith(
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _accountNameController,
          style: TextStyles.body1,
          decoration: const InputDecoration(
            hintText: 'Max of 50 characters',
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Account Number',
          style: TextStyles.body2.copyWith(
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _accountNumberController,
          keyboardType: TextInputType.number,
          style: TextStyles.body1,
          decoration: const InputDecoration(
            hintText: '10 to 14 digits',
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Send Receipt To (Optional)',
          style: TextStyles.body2.copyWith(
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyles.body1,
          decoration: const InputDecoration(
            hintText: 'Enter email Address',
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }

  void _processTransfer() {
    // Validate form
    if (_amountController.text.isEmpty ||
        _accountNameController.text.isEmpty ||
        _accountNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
        ),
      );
      return;
    }

    // Navigate to confirmation screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BankTransferConfirmationScreen(
          bankName: widget.bankName,
          amount: double.parse(_amountController.text),
          accountName: _accountNameController.text,
          accountNumber: _accountNumberController.text,
          email: _emailController.text,
        ),
      ),
    );
  }
}