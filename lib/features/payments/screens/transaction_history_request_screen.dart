import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';

class TransactionHistoryRequestScreen extends StatefulWidget {
  const TransactionHistoryRequestScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryRequestScreen> createState() => _TransactionHistoryRequestScreenState();
}

class _TransactionHistoryRequestScreenState extends State<TransactionHistoryRequestScreen> {
  String _selectedOption = 'Last 30 days';
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Request Transactions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction History Request',
              style: TextStyles.subtitle1,
            ),
            const SizedBox(height: 8),
            Text(
              'Your request will be sent to: johndoe@gmail.com',
              style: TextStyles.caption,
            ),
            const SizedBox(height: 24),
            Text(
              'Date Range',
              style: TextStyles.body1,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              value: _selectedOption,
              items: ['Last 30 days', 'Last 60 days', 'Last 90 days', 'Custom range'],
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
              hint: 'Selection Option',
            ),
            const SizedBox(height: 16),
            Text(
              'From',
              style: TextStyles.body2,
            ),
            const SizedBox(height: 8),
            _buildDatePicker(
              value: _fromDate,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: AppColors.primaryBlue,
                          onPrimary: Colors.white,
                          surface: AppColors.cardBackground,
                          onSurface: AppColors.textWhite,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (date != null) {
                  setState(() {
                    _fromDate = date;
                  });
                }
              },
              hint: 'Selection a start date',
            ),
            const SizedBox(height: 16),
            Text(
              'To',
              style: TextStyles.body2,
            ),
            const SizedBox(height: 8),
            _buildDatePicker(
              value: _toDate,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: AppColors.primaryBlue,
                          onPrimary: Colors.white,
                          surface: AppColors.cardBackground,
                          onSurface: AppColors.textWhite,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (date != null) {
                  setState(() {
                    _toDate = date;
                  });
                }
              },
              hint: 'Selection a start date',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Submit request logic
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Request submitted successfully'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.cardBackground,
          style: TextStyles.body1,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.textWhite,
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: Text(
            hint,
            style: TextStyles.body1.copyWith(
              color: AppColors.textGrey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required DateTime? value,
    required VoidCallback onTap,
    required String hint,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value != null
                  ? '${value.day}/${value.month}/${value.year}'
                  : hint,
              style: TextStyles.body1.copyWith(
                color: value != null ? AppColors.textWhite : AppColors.textGrey,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: AppColors.textWhite,
            ),
          ],
        ),
      ),
    );
  }
}