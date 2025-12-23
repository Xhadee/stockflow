import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget buildCustomerCard(BuildContext context,
    {required String name,
      required String phone,
      required int totalOrders,
      required String id}) {
  return InkWell(
    onTap: () => context.push('/customer-detail/$id'),
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar avec initiales
          CircleAvatar(
            backgroundColor: const Color(0xFFE3F2FD),
            child: Text(
              name.substring(0, 1).toUpperCase(),
              style: const TextStyle(color: Color(0xFF2A85FF), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          // Infos client
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          // Indicateur du nombre de commandes
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "$totalOrders cmd",
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 4),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    ),
  );
}