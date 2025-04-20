import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import 'face_id_screen.dart';
import 'fingerprint_screen.dart';

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Security Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSecurityItem(
              context,
              title: 'Face ID',
              icon: Icons.face,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaceIdScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _buildSecurityItem(
              context,
              title: 'Fingerprint',
              icon: Icons.fingerprint,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FingerprintScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _buildSecurityItem(
              context,
              title: 'Change PIN',
              icon: Icons.pin,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Change PIN feature will be implemented soon')),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildSecurityItem(
              context,
              title: 'Change Password',
              icon: Icons.lock,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Change Password feature will be implemented soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityItem(
      BuildContext context, {
        required String title,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.darkBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyles.body1,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textWhite,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}