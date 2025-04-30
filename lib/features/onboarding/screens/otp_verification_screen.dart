import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../dashboard/screens/dashboard_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isLogin;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.isLogin,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
        (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
        (_) => FocusNode(),
  );

  int secondsRemaining = 30;
  bool isVerifying = false;
  bool canResend = false;
  late final timer = Ticker(_tick);

  void _tick(Duration _) {
    if (secondsRemaining > 0) {
      setState(() {
        secondsRemaining--;
      });
    } else {
      timer.stop();
      setState(() {
        canResend = true;
      });
    }
  }

  void _resendCode() {
    if (canResend) {
      setState(() {
        secondsRemaining = 30;
        canResend = false;
      });
      timer.start();

      // Show a snackbar to indicate code was resent
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification code resent'),
          backgroundColor: Color(0xFF2F6BFF),
        ),
      );
    }
  }

  void _verifyOtp() {
    // Get the complete OTP
    final otp = _controllers.map((controller) => controller.text).join();

    // Check if OTP is complete
    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete 4-digit code'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isVerifying = true;
    });

    // Simulate verification delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isVerifying = false;
      });

      // Navigate to dashboard on successful verification
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
            (route) => false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    timer.start();

    // Set up focus listeners for OTP fields
    for (int i = 0; i < 4; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus && _controllers[i].text.isNotEmpty) {
          _controllers[i].selection = TextSelection(
            baseOffset: 0,
            extentOffset: _controllers[i].text.length,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    timer.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E2C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'One-Time ',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'PIN',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F6BFF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Please enter the one-time pin we sent\nto ${widget.phoneNumber}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 32),

            // OTP Input
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 60,
                  height: 60,
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        if (index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        } else {
                          _focusNodes[index].unfocus();
                        }
                      }
                    },
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2F6BFF), width: 2),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),

            // Verify Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isVerifying ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6BFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBackgroundColor: const Color(0xFF2F6BFF).withOpacity(0.5),
                ),
                child: isVerifying
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text(
                  'Verify',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Countdown text
            Center(
              child: GestureDetector(
                onTap: _resendCode,
                child: Text(
                  canResend
                      ? 'Resend code'
                      : 'Resend code in $secondsRemaining seconds',
                  style: TextStyle(
                    color: const Color(0xFF2F6BFF),
                    fontWeight: canResend ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Simple timer class since we don't want to depend on external packages
class Ticker {
  final void Function(Duration) onTick;
  late final Stopwatch _stopwatch;
  late final Duration _interval;
  bool _isRunning = false;

  Ticker(this.onTick) {
    _interval = const Duration(seconds: 1);
    _stopwatch = Stopwatch();
  }

  void start() {
    if (!_isRunning) {
      _isRunning = true;
      _stopwatch.start();
      _tick();
    }
  }

  void stop() {
    _isRunning = false;
    _stopwatch.stop();
    _stopwatch.reset();
  }

  void dispose() {
    stop();
  }

  void _tick() async {
    while (_isRunning) {
      await Future.delayed(_interval);
      if (_isRunning) {
        onTick(_stopwatch.elapsed);
      }
    }
  }
}
