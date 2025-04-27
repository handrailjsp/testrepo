import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import 'support_chat_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> commonQuestions = const [
    {
      'question': 'I have a transaction concern. What do I do?',
      'icon': 'transaction'
    },
    {
      'question': 'How do I pay my Cha-Ching bill?',
      'icon': 'bill'
    },
    {
      'question': 'How do I change my registered number?',
      'icon': 'number'
    },
    {
      'question': 'How do I freeze my card?',
      'icon': 'card'
    },
    {
      'question': 'How do I apply for a loan?',
      'icon': 'loan'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Help', style: TextStyles.subtitle1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cha-Ching',
              style: TextStyles.heading1.copyWith(color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                style: TextStyles.body1,
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: Colors.white),
                  hintText: 'Find help',
                  hintStyle: TextStyles.body1.copyWith(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Common questions',
              style: TextStyles.subtitle1,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: commonQuestions.length,
                itemBuilder: (context, index) {
                  final question = commonQuestions[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: _getIconForQuestion(question['icon']!),
                      title: Text(
                        question['question']!,
                        style: const TextStyle(color: Colors.black87),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SupportChatScreen(initialQuestion: question['question']),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SupportChatScreen(),
                    ),
                  );
                },
                child: Text("Contact Support", style: TextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconForQuestion(String iconType) {
    IconData iconData;
    Color iconColor;

    switch (iconType) {
      case 'transaction':
        iconData = Icons.receipt_long;
        iconColor = Colors.blue;
        break;
      case 'bill':
        iconData = Icons.receipt;
        iconColor = Colors.green;
        break;
      case 'number':
        iconData = Icons.phone;
        iconColor = Colors.orange;
        break;
      case 'card':
        iconData = Icons.credit_card;
        iconColor = Colors.purple;
        break;
      case 'loan':
        iconData = Icons.account_balance;
        iconColor = Colors.red;
        break;
      default:
        iconData = Icons.help_outline;
        iconColor = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: iconColor.withOpacity(0.1),
      child: Icon(iconData, color: iconColor),
    );
  }
}