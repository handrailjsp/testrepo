import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _isPushNotificationsEnabled = true;
  bool _isEmailNotificationsEnabled = true;
  bool _isTransactionAlertsEnabled = true;
  bool _isPromotionalNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Notification Settings'),
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Channels',
              style: TextStyles.subtitle2.copyWith(color: AppColors.textGrey),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              title: 'Push Notifications',
              subtitle: 'Receive notifications on your device',
              isEnabled: _isPushNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _isPushNotificationsEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              title: 'Email Notifications',
              subtitle: 'Receive notifications via email',
              isEnabled: _isEmailNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _isEmailNotificationsEnabled = value;
                });
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Notification Types',
              style: TextStyles.subtitle2.copyWith(color: AppColors.textGrey),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              title: 'Transaction Alerts',
              subtitle: 'Get notified about account transactions',
              isEnabled: _isTransactionAlertsEnabled,
              onChanged: (value) {
                setState(() {
                  _isTransactionAlertsEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              title: 'Promotional Notifications',
              subtitle: 'Receive updates about offers and promotions',
              isEnabled: _isPromotionalNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _isPromotionalNotificationsEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    required bool isEnabled,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.body1,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyles.caption.copyWith(color: AppColors.textGrey),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: onChanged,
            activeColor: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}
