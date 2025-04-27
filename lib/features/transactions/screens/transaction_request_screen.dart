import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';

class TransactionRequestScreen extends StatefulWidget {
  const TransactionRequestScreen({Key? key}) : super(key: key);

  @override
  State<TransactionRequestScreen> createState() => _TransactionRequestScreenState();
}

class _TransactionRequestScreenState extends State<TransactionRequestScreen> {
  String? selectedOption;
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              surface: AppColors.cardBackground,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: AppColors.darkBackground,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Request Transactions',
          style: TextStyles.subtitle1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Transaction History Request",
              style: TextStyles.subtitle1,
            ),
            const SizedBox(height: 8),
            Text(
              "Your request will be sent to: shaqpangit@gmail.com",
              style: TextStyles.caption,
            ),
            const SizedBox(height: 24),
            Text(
              "Date Range",
              style: TextStyles.body1,
            ),
            const SizedBox(height: 10),
            _buildDropdownField(
              value: selectedOption,
              hint: "Selection Option",
              items: ["Last 7 Days", "Last 30 Days", "Custom"],
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              "From",
              style: TextStyles.body1,
            ),
            const SizedBox(height: 8),
            _buildDateField(
              context,
              label: startDate == null ? "Select a start date" : _formatDate(startDate!),
              onTap: () => _pickDate(context, true),
            ),
            const SizedBox(height: 20),
            Text(
              "To",
              style: TextStyles.body1,
            ),
            const SizedBox(height: 8),
            _buildDateField(
              context,
              label: endDate == null ? "Select an end date" : _formatDate(endDate!),
              onTap: () => _pickDate(context, false),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Submit action
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transaction history request submitted'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Submit Request",
                    style: TextStyles.button,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Widget _buildDropdownField({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<String>(
        dropdownColor: AppColors.cardBackground,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        value: value,
        hint: Text(hint, style: TextStyles.body2.copyWith(color: Colors.grey)),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        items: items.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val, style: TextStyles.body1),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDateField(BuildContext context, {required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyles.body1),
            const Icon(Icons.calendar_today, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}