import 'package:flutter/material.dart';

import 'build_order_card.dart';


Widget buildOrderList({required String filter}) {
  return ListView.separated(
    padding: const EdgeInsets.all(16),
    itemCount: 8, // Données de test
    separatorBuilder: (context, index) => const SizedBox(height: 12),
    itemBuilder: (context, index) {
      return buildOrderCard(
        context,
        orderId: "CMD-${index}",
        customer: "Client $index",
        amount: "${(index + 1) * 15000} F",
        status: index % 2 == 0 ? "En attente" : "Livrée",
        date: "22 Déc. 2025",
      );
    },
  );
}