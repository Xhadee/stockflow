import 'package:flutter/material.dart';

Widget buildSettingsTile({
  required IconData icon,
  required String title,
  String? subtitle,
  Widget? trailing,
  VoidCallback? onTap,
}) {
  return ListTile(
    onTap: onTap,
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: const Color(0xFF2A85FF), size: 20),
    ),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
    subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12)) : null,
    trailing: trailing ?? const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
  );
}