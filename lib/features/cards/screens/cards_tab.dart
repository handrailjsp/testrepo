import 'package:flutter/material.dart';
import 'cards_screen.dart';

class CardsTab extends StatelessWidget {
  const CardsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is just a wrapper to integrate with the dashboard
    return const CardsScreen();
  }
}
