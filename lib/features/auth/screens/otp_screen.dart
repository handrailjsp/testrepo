import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import '../../dashboard/screens/dashboard_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  int _resendSeconds = 30;
  bool _isResendActive = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_resendSeconds > 0) {
            _resendSeconds--;
            _startResendTimer();
          } else {
            _isResendActive = true;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'One-Time PIN',
              style: TextStyles.heading2,
            ),
            const SizedBox(height: 8),
            Text(
              'Please enter the one-time pin we sent to +63 09876543210',
              style: TextStyles.body2,
            ),
            const SizedBox(height: 40),
            _buildOtpFields(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: const Text('Verify'),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: _isResendActive
                    ? () {
                        setState(() {
                          _resendSeconds = 30;
                          _isResendActive = false;
                        });
                        _startResendTimer();
                        // Resend OTP logic here
                      }
                    : null,
                child: Text(
                  _isResendActive
                      ? 'Resend code'
                      : 'Resend code in $_resendSeconds seconds',
                  style: TextStyles.body2.copyWith(
                    color: _isResendActive
                        ? AppColors.primaryBlue
                        : AppColors.textGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => SizedBox(
          width: 60,
          height: 60,
          child: TextField(
            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              if (index == 3 && value.length == 1) {
                _verifyOtp();
              }
            },
            style: TextStyles.heading2,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primaryBlue,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _verifyOtp() {
    // For demo purposes, navigate to dashboard
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
      (route) => false,
    );
  }
}