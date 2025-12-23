import 'package:flutter/material.dart';


Widget contactTile(IconData icon, String label, String value) {
  return Row(
    children: [
      Icon(icon, color: Colors.grey.shade400, size: 22),
      const SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ],
      ),
    ],
  );
}
