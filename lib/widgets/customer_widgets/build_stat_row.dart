import 'package:flutter/material.dart';
import 'package:stockflow/widgets/customer_widgets/stat_card.dart';


Widget buildStatsRow() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        statCard("Commandes", "12", Icons.shopping_bag_outlined, Colors.blue),
        const SizedBox(width: 12),
        statCard("Total Achats", "450.000 F", Icons.payments_outlined, Colors.green),
      ],
    ),
  );
}
