import 'package:flutter/material.dart';
import 'screens/auth//login_screen.dart';

void main() {
  runApp(const StockFlowApp());
}

class StockFlowApp extends StatelessWidget {
  const StockFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockFlow',
      theme: ThemeData(useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}
