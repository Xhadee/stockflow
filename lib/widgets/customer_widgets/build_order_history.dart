import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



// 4. Liste des commandes récentes
Widget buildOrderHistory() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text("Commandes Récentes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
                onPressed: () {
                  context.push('/order-detail/$index');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CMD-#$index", style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                        const Text("12 Déc. 2024", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const Text("45.000 FCFA", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
            )
          );
        },
      ),
    ],
  );
}