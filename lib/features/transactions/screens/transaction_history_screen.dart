import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Income', 'Expense'];

  // Mock transaction data
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'TX123456789',
      'title': 'Online Purchase',
      'amount': 250.00,
      'isExpense': true,
      'date': 'May 15, 2023',
      'time': '10:30 AM',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'id': 'TX123456788',
      'title': 'Salary Deposit',
      'amount': 25000.00,
      'isExpense': false,
      'date': 'May 1, 2023',
      'time': '9:00 AM',
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'id': 'TX123456787',
      'title': 'Restaurant',
      'amount': 450.00,
      'isExpense': true,
      'date': 'April 30, 2023',
      'time': '7:30 PM',
      'icon': Icons.fastfood_outlined,
    },
    {
      'id': 'TX123456786',
      'title': 'Transfer from John',
      'amount': 1000.00,
      'isExpense': false,
      'date': 'April 28, 2023',
      'time': '3:15 PM',
      'icon': Icons.arrow_downward,
    },
    {
      'id': 'TX123456785',
      'title': 'Utility Bill',
      'amount': 1200.00,
      'isExpense': true,
      'date': 'April 25, 2023',
      'time': '11:45 AM',
      'icon': Icons.bolt,
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    if (_selectedFilter == 'All') {
      return _transactions;
    } else if (_selectedFilter == 'Income') {
      return _transactions.where((tx) => !tx['isExpense']).toList();
    } else {
      return _transactions.where((tx) => tx['isExpense']).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Transaction History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: filteredTransactions.isEmpty
                ? const Center(
              child: Text('No transactions found'),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];
                return _buildTransactionItem(transaction);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction History',
            style: TextStyles.subtitle1,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = filter == _selectedFilter;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryBlue : AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyles.body2.copyWith(
                          color: isSelected ? Colors.white : AppColors.textGrey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final isExpense = transaction['isExpense'] as bool;
    final amount = transaction['amount'] as double;
    final formattedAmount = '${isExpense ? '-' : '+'} ₱ ${amount.toStringAsFixed(2)}';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/transaction-details');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                transaction['icon'],
                color: isExpense ? AppColors.error : AppColors.success,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['title'],
                    style: TextStyles.body1,
                  ),
                  Text(
                    '${transaction['date']} at ${transaction['time']}',
                    style: TextStyles.caption,
                  ),
                ],
              ),
            ),
            Text(
              formattedAmount,
              style: TextStyles.body1.copyWith(
                color: isExpense ? AppColors.error : AppColors.success,
              ),
            ),
          ],
        ),
      ),
    );
  }
}