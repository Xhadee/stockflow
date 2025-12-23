import 'package:flutter/material.dart';

// 1. En-tête avec Avatar et Nom
Widget buildProfileHeader() {
  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFFE3F2FD),
          child: Text("PD", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2A85FF))),
        ),
        const SizedBox(height: 12),
        const Text("Papa Samour DIOP", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text("Client depuis Janvier 2024", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
      ],
    ),
  );
}