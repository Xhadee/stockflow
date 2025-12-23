import 'package:flutter/material.dart';

Widget buildSettingsGroup(List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade100),
    ),
    child: Column(
      children: children,
    ),
  );
}