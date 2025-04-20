import 'package:flutter/material.dart';
import 'add_card_screen.dart';
import 'card_details_screen.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1535), // Dark navy background
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1535),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Manage Cards',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Cards',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildCardsList(context),
            const SizedBox(height: 8),
            _buildPageIndicator(),
            const SizedBox(height: 24),
            const Text(
              'Add new card',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildAddNewCard(context),
            const SizedBox(height: 24),
            _buildRecentActivities(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCardsList(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView(
        children: [
          _buildCardItem(
            context,
            cardColor: const Color(0xFF2D7BF0), // Bright blue
            cardType: 'VISA',
            cardLabel: 'Platinum',
            cardHolder: 'Rendy Vickriansyah',
            cardNumber: '1416 0212',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardDetailsScreen(
                    cardColor: const Color(0xFF2D7BF0),
                    cardNumber: '1416 0212',
                    cardHolder: 'Rendy Vickriansyah',
                    cardType: 'VISA',
                    cardLabel: 'Platinum',
                  ),
                ),
              );
            },
          ),
          _buildCardItem(
            context,
            cardColor: const Color(0xFF9C2CF3), // Purple
            cardType: 'VISA',
            cardLabel: 'Platinum',
            cardHolder: 'Rendy Vickriansyah',
            cardNumber: '5678 9012',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardDetailsScreen(
                    cardColor: const Color(0xFF9C2CF3),
                    cardNumber: '5678 9012',
                    cardHolder: 'Rendy Vickriansyah',
                    cardType: 'VISA',
                    cardLabel: 'Platinum',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem(
      BuildContext context, {
        required Color cardColor,
        required String cardType,
        required String cardLabel,
        required String cardHolder,
        required String cardNumber,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 180,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: const NetworkImage('https://placeholder.svg?height=200&width=350&text='),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cardType,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cardLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    cardHolder,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        cardNumber,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Orange bottom border
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFF57C00),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 16,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildAddNewCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddCardScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFF9C2CF3), // Purple
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: const NetworkImage('https://placeholder.svg?height=200&width=350&text='),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'VISA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Platinum',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'Card Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '••••••••',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            // Orange bottom border
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFF57C00),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activities',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTransactionItem(
          icon: Icons.arrow_downward,
          title: 'Receive Transfer',
          date: '10 Oct 2023',
          amount: '+ ₱ 260,00',
          isExpense: false,
        ),
        _buildTransactionItem(
          icon: Icons.arrow_upward,
          title: 'Sent Transfer',
          date: '09 Oct 2023',
          amount: '- ₱ 260,00',
          isExpense: true,
        ),
        _buildTransactionItem(
          icon: Icons.arrow_downward,
          title: 'Receive Transfer',
          date: '08 Oct 2023',
          amount: '+ ₱ 260,00',
          isExpense: false,
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required String title,
    required String date,
    required String amount,
    required bool isExpense,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2243),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isExpense ? Colors.red : Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isExpense ? Colors.red : Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
