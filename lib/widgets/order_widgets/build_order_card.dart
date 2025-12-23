import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Widget buildOrderCard(BuildContext context, {
  required String orderId,
  required String customer,
  required String amount,
  required String status,
  required String date,
}) {
  bool isPending = status == "En attente";

  return InkWell(
    onTap: () => context.push('/order-detail/$orderId'),
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          // Icône de statut
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isPending ? const Color(0xFFFFF3E0) : const Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPending ? Icons.access_time_rounded : Icons.check_circle_outline,
              color: isPending ? Colors.orange : Colors.green,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          // Détails
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(orderId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(customer, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                const SizedBox(height: 4),
                Text(date, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    ),
  );
}
