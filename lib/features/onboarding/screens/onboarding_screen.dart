import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'get_started_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Send',
      description: 'Send money to friends and family with just a few taps, no fees attached!',
      iconData: Icons.send,
    ),
    OnboardingPage(
      title: 'Save',
      description: 'Set savings goals and watch your money grow with our competitive interest rates.',
      iconData: Icons.savings,
    ),
    OnboardingPage(
      title: 'Invest',
      description: 'Grow your wealth with our easy-to-use investment tools and expert guidance.',
      iconData: Icons.trending_up,
    ),
    OnboardingPage(
      title: 'Pay',
      description: 'Pay your bills, buy load, and scan QR code to pay, including from other apps!',
      iconData: Icons.payment,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C2C),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: const Color(0xFF2F6BFF),
              child: const Text(
                'Cha-Ching',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                    (index) => _buildPageIndicator(index),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GetStartedScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFF2F6BFF).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            page.iconData,
            size: 100,
            color: const Color(0xFF2F6BFF),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          page.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(int index) {
    bool isActive = index == _currentPage;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white70,
        shape: BoxShape.circle,
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData iconData;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.iconData,
  });
}
