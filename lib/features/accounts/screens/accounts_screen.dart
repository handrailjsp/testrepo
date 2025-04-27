import 'package:flutter/material.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFF0D0D3C);
    Color cardColor = const Color(0xFF1E1E5A);
    Color textColor = Colors.white;
    Color green = Colors.greenAccent;
    Color red = Colors.redAccent;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: textColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Accounts', style: TextStyle(color: textColor)),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add, color: textColor),
            label: Text("Add new account", style: TextStyle(color: textColor)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Account List", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
            Text("You have 2 active cards", style: TextStyle(color: textColor.withOpacity(0.6))),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildSummaryCard("Monthly Income", "₱ 6,000.00", green)),
                const SizedBox(width: 10),
                Expanded(child: _buildSummaryCard("Monthly Expense", "₱ 410.00", red)),
              ],
            ),
            const SizedBox(height: 20),
            _buildAccountCard("Account 1", "₱ 654,000.00", "20%", green),
            const SizedBox(height: 20),
            _buildAccountCard("Account 2", "₱ 654,000.00", "30%", red),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String amount, Color lineColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E5A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          SizedBox(
            height: 20,
            child: CustomPaint(
              painter: _LineGraphPainter(color: lineColor),
              size: const Size(double.infinity, 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard(String accountName, String balance, String percentage, Color percentColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E5A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white)),
              const SizedBox(width: 12),
              Text(accountName, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              const Spacer(),
              const Text("VISA", style: TextStyle(color: Colors.white)),
              const Icon(Icons.more_horiz, color: Colors.white)
            ],
          ),
          const SizedBox(height: 16),
          const Text("Total Balance", style: TextStyle(color: Colors.white70)),
          Row(
            children: [
              Text(balance, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(percentage, style: TextStyle(color: percentColor)),
              Icon(
                percentColor == Colors.greenAccent ? Icons.arrow_upward : Icons.arrow_downward,
                color: percentColor,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildBalanceTile("Savings"),
              _buildBalanceTile("Checking"),
              _buildBalanceTile("Credits"),
              _buildBalanceTile("Loans"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceTile(String title) {
    return Container(
      width: 140,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E6F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          "$title\n******",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
    );
  }
}

class _LineGraphPainter extends CustomPainter {
  final Color color;

  _LineGraphPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.1, size.width * 0.6, size.height * 0.8)
      ..quadraticBezierTo(size.width * 0.85, size.height, size.width, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
