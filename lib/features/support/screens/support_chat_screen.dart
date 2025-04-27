import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';

class SupportChatScreen extends StatefulWidget {
  final String? initialQuestion;

  const SupportChatScreen({Key? key, this.initialQuestion}) : super(key: key);

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.initialQuestion != null) {
      _addMessage('user', widget.initialQuestion!);
      Future.delayed(const Duration(milliseconds: 300), () {
        _addMessage('bot', _getBotResponse(widget.initialQuestion!));
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addMessage(String sender, String text) {
    setState(() {
      messages.add({'sender': sender, 'text': text});
    });

    // Auto scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getBotResponse(String question) {
    question = question.toLowerCase();
    if (question.contains('transaction')) {
      return 'You can view your transaction history in the Cha-Ching app under the "Transactions" tab.';
    } else if (question.contains('bill')) {
      return 'You can pay your Cha-Ching bill through the "Pay Bills" section.';
    } else if (question.contains('number')) {
      return 'To change your registered number, go to Settings > Account > Change Number.';
    } else if (question.contains('card')) {
      return 'You can manage your cards in the "Cards" section of the app. You can add new cards, freeze existing ones, or set spending limits.';
    } else if (question.contains('loan')) {
      return 'To apply for a loan, go to the "Loans" section and check your eligibility. We offer personal, business, and emergency loans.';
    } else {
      return "I'm not sure about that, but you can contact a live agent for more help by calling our hotline at +63 123 456 7890.";
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _addMessage('user', text);
    _controller.clear();

    Future.delayed(const Duration(milliseconds: 500), () {
      _addMessage('bot', _getBotResponse(text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        title: Text(
          'Cha-Ching Support Chat',
          style: TextStyles.subtitle1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.primaryBlue : const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: const Color(0xFFF0F0F0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Always check key info since our chatbot can make mistakes",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (_) => _handleSend(),
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send, color: AppColors.primaryBlue),
                      onPressed: _handleSend,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}