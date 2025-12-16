import 'package:flutter/material.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: const Text(
              "SelectScreenPage"
          )
      ),
    );
  }
}