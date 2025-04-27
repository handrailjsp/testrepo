import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import 'faceid_setup.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({Key? key}) : super(key: key);

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _isFaceIDEnabled = false;
  bool _isChangePasswordEnabled = true;
  bool _isDeviceManagementEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Security Settings'),
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
              'Authentication',
              style: TextStyles.subtitle2.copyWith(color: AppColors.textGrey),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              title: 'Face ID',
              subtitle: 'Use Face ID for secure login',
              isEnabled: _isFaceIDEnabled,
              onChanged: (value) {
                setState(() {
                  _isFaceIDEnabled = value;
                });
                if (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FaceIDSetupScreen(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Account Security',
              style: TextStyles.subtitle2.copyWith(color: AppColors.textGrey),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              title: 'Change Password',
              subtitle: 'Update your account password',
              isEnabled: _isChangePasswordEnabled,
              onChanged: (value) {
                setState(() {
                  _isChangePasswordEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              title: 'Device Management',
              subtitle: 'Manage devices that can access your account',
              isEnabled: _isDeviceManagementEnabled,
              onChanged: (value) {
                setState(() {
                  _isDeviceManagementEnabled = value;
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
