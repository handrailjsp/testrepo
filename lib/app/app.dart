import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../features/dashboard/screens/dashboard_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'Cha-Ching',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF2D7BF0),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFF2D7BF0),
          secondary: const Color(0xFF2D7BF0),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}