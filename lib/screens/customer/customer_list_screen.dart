import 'package:flutter/material.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: const Text(
              "CustomerListScreenPage"
          )
      ),
    );
  }
}